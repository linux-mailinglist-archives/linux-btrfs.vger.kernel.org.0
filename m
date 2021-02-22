Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803EF321BD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBVPtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 10:49:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:56090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhBVPs7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:48:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27C40AF4C;
        Mon, 22 Feb 2021 15:48:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E682DDA7FF; Mon, 22 Feb 2021 16:46:16 +0100 (CET)
Date:   Mon, 22 Feb 2021 16:46:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RFC] btrfs-progs: format-output: remove newline in fmt_end text
 mode
Message-ID: <20210222154616.GQ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
References: <20210216162840.167845-1-realwakka@gmail.com>
 <20210219215611.GM1993@twin.jikos.cz>
 <20210220164238.GB11258@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220164238.GB11258@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 20, 2021 at 04:42:38PM +0000, Sidong Yang wrote:
> On Fri, Feb 19, 2021 at 10:56:11PM +0100, David Sterba wrote:
> > On Tue, Feb 16, 2021 at 04:28:40PM +0000, Sidong Yang wrote:
> > > Remove a code that inserting new line in fmt_end() for text mode.
> > > Old code made a failure in fstest btrfs/006.
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > > Hi, I've just read mail that Filipe written that some failure about fstest.
> > > I'm worried about this patch makes other problem. So make it RFC. Thanks.
> > 
> > I found the discussion under the device stats patch adding json, the
> > added line was known and "hopefully not causing problems", but the
> > fstests seem to notice.
> > 
> > I think we can fix that by removing the fmt_end newline but we also need
> > to update how the fmt_print is done for the text output. Ie. for json
> > there are some strict rules for line continuations  (",") but for the
> > textual output, each line ended by "\n" right away, without delaying
> > that to the next fmt_* call should work.
> 
> You mean that if this patch applied and the code prints device stats for
> text format manually replaced to fmt_print(), there is no last new line
> for text output? fmt_print() prints new line before print some value now.
> I think that it should prints new line at the end of each fmt_print().
> like below
> 
> diff --git a/common/format-output.c b/common/format-output.c
> index f5b12548..9a9f5bf7 100644
> --- a/common/format-output.c
> +++ b/common/format-output.c
> @@ -242,7 +239,6 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
>                 const bool print_colon = row->out_text[0];
>                 int len;
>  
> -               putchar('\n');
>                 fmt_indent1(fctx->indent);
>                 len = strlen(row->out_text);
>  
> @@ -312,6 +308,8 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
>         }
>  
>         fmt_end_value(fctx, row);
> +       if (bconf.output_format == CMD_FORMAT_TEXT)
> +               putchar('\n');

Yeah effectively that, but inside fmt_end_value and removing it from
fmt_end. It's fixed in devel now with some comments updated as the plain
text and json are different.
