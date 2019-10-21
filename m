Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36FDEF62
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfJUOYL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Oct 2019 10:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUOYL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 10:24:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DFC20640;
        Mon, 21 Oct 2019 14:24:09 +0000 (UTC)
Date:   Mon, 21 Oct 2019 10:24:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Message-ID: <20191021102408.3bb4aa8b@gandalf.local.home>
In-Reply-To: <3830b0c5-5b76-36c1-5e3a-64dad62f76fb@gmx.com>
References: <20191021094730.57332-1-wqu@suse.com>
        <20191021095625.2dfe3359@gandalf.local.home>
        <3830b0c5-5b76-36c1-5e3a-64dad62f76fb@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 21 Oct 2019 22:03:21 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> On 2019/10/21 下午9:56, Steven Rostedt wrote:
> > On Mon, 21 Oct 2019 17:47:30 +0800
> > Qu Wenruo <wqu@suse.com> wrote:
> >   
> >> +static void print_uuid_arg(struct trace_seq *s, void *data, int size,
> >> +			   struct tep_event *event, struct tep_print_arg *arg)
> >> +{
> >> +	unsigned char *buf;
> >> +	int i;
> >> +
> >> +	if (arg->type != TEP_PRINT_FIELD) {
> >> +		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
> >> +		return;
> >> +	}
> >> +
> >> +	if (!arg->field.field) {
> >> +		arg->field.field = tep_find_any_field(event, arg->field.name);
> >> +		if (!arg->field.field) {
> >> +			do_warning("%s: field %s not found",
> >> +				   __func__, arg->field.name);
> >> +			return;
> >> +		}
> >> +	}
> >> +	if (arg->field.field->size < 16) {
> >> +		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
> >> +				arg->field.field->size);
> >> +		return;
> >> +	}
> >> +	buf = data + arg->field.field->offset;
> >> +
> >> +	for (i = 0; i < 8; i++) {
> >> +		trace_seq_printf(s, "%02x", buf[2 * i]);
> >> +		trace_seq_printf(s, "%02x", buf[2 * i + 1]);
> >> +		if (1 <= i && i <= 4)  
> > 
> > I'm fine with this patch except for one nit. The above is hard to read
> > (in my opinion), and I absolutely hate the "constant" compare to
> > "variable" notation. Please change the above to:
> > 
> > 		if (i >= 1 && i <= 4)  
> 
> Isn't this ( 1 <= i && i <= 4 ) easier to find out the lower and upper
> boundary? only two numbers, both at the end of the expression.

I don't read it like that.

> 
> I feel that ( i >= 1 && i <= 4 ) easier to write, but takes me extra
> half second to read, thus I changed to the current one.

How do you read it in English?

  "If one is less than or equal to i and i is less than or equal to
  four."

Or

  "If i is greater than or equal to one and i is less than or equal to
   four."

?

I read it the second way, and I believe most English speakers read it
that way too.

It took me a minute or two to understand the original method, because
my mind likes to take a variable and keep it on the same side of the
comparison, and the variable should always be first.

-- Steve


