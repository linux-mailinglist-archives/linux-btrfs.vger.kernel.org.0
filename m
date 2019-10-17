Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84625DAB8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409328AbfJQLyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 07:54:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405897AbfJQLyP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 07:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3A38AEF6;
        Thu, 17 Oct 2019 11:54:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3F9BDA808; Thu, 17 Oct 2019 13:54:23 +0200 (CEST)
Date:   Thu, 17 Oct 2019 13:54:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v2] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Message-ID: <20191017115423.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <20191017022800.31866-1-wqu@suse.com>
 <20191017115209.GG2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017115209.GG2751@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 17, 2019 at 01:52:09PM +0200, David Sterba wrote:
> On Thu, Oct 17, 2019 at 10:28:00AM +0800, Qu Wenruo wrote:
> > [BUG]
> > For btrfs related events, there is a field for fsid, but perf never
> > parse it correctly.
> > 
> >  # perf trace -e btrfs:qgroup_meta_convert xfs_io -f -c "pwrite 0 4k" \
> >    /mnt/btrfs/file1
> >      0.000 xfs_io/77915 btrfs:qgroup_meta_reserve:(nil)U: refroot=5(FS_TREE) type=0x0 diff=2
> >                                                   ^^^^^^ Not a correct UUID
> >      ...
> > 
> > [CAUSE]
> > The pretty_print() function doesn't handle the %pU format correctly.
> > In fact it doesn't handle %pU as uuid at all.
> > 
> > [FIX]
> > Add a new function, print_uuid_arg(), to handle %pU correctly.
> > 
> > Now perf trace can at least print fsid correctly:
> >      0.000 xfs_io/79619 btrfs:qgroup_meta_reserve:23ad1511-dd83-47d4-a79c-e96625a15a6e refroot=5(FS_TREE) type=0x0 diff=2
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v2:
> > - Use more comment explaining the finetunings we skipped for %pU*
> > - Use more elegant way to output uuid string
> > ---
> >  tools/lib/traceevent/event-parse.c | 56 ++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> > index d948475585ce..3c9473f46efe 100644
> > --- a/tools/lib/traceevent/event-parse.c
> > +++ b/tools/lib/traceevent/event-parse.c
> > @@ -18,6 +18,7 @@
> >  #include <errno.h>
> >  #include <stdint.h>
> >  #include <limits.h>
> > +#include <linux/uuid.h>
> >  #include <linux/time64.h>
> >  
> >  #include <netinet/in.h>
> > @@ -4508,6 +4509,45 @@ get_bprint_format(void *data, int size __maybe_unused,
> >  	return format;
> >  }
> >  
> > +static void print_uuid_arg(struct trace_seq *s, void *data, int size,
> > +			   struct tep_event *event, struct tep_print_arg *arg)
> > +{
> > +	unsigned char *buf;
> > +	int i;
> > +
> > +	if (arg->type != TEP_PRINT_FIELD) {
> > +		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
> > +		return;
> > +	}
> > +
> > +	if (!arg->field.field) {
> > +		arg->field.field = tep_find_any_field(event, arg->field.name);
> > +		if (!arg->field.field) {
> > +			do_warning("%s: field %s not found",
> > +				   __func__, arg->field.name);
> > +			return;
> > +		}
> > +	}
> > +	if (arg->field.field->size < 16) {
> > +		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
> > +				arg->field.field->size);
> > +		return;
> > +	}
> 
> So if there's an interest for very compact printing loop, something like
> this produces the same output:
> 
> 	for (i = 0; i < 8; i++) {
> 		printf("%02X", buf[i]);
> 		printf("%02X", buf[i]);

Ok, test-before-post failure, this should be

		printf("%02X", buf[2 * i]);
	        printf("%02X", buf[2 * i + 1]);

> 		if (1 <= i && i <= 4)
> 			putchar('-');
> 	}
