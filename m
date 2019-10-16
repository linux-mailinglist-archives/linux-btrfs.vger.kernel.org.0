Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC9D9465
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbfJPOy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 10:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfJPOy6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 10:54:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAACE2168B;
        Wed, 16 Oct 2019 14:54:57 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:54:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Message-ID: <20191016105456.0b8d2310@gandalf.local.home>
In-Reply-To: <20191016063920.20791-1-wqu@suse.com>
References: <20191016063920.20791-1-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 16 Oct 2019 14:39:20 +0800
Qu Wenruo <wqu@suse.com> wrote:

> +static void print_uuid_arg(struct trace_seq *s, void *data, int size,
> +			   struct tep_event *event, struct tep_print_arg *arg)
> +{
> +	const char *fmt;
> +	unsigned char *buf;
> +
> +	fmt = "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x";
> +	if (arg->type != TEP_PRINT_FIELD) {
> +		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
> +		return;
> +	}
> +
> +	if (!arg->field.field) {
> +		arg->field.field = tep_find_any_field(event, arg->field.name);
> +		if (!arg->field.field) {
> +			do_warning("%s: field %s not found",
> +				   __func__, arg->field.name);
> +			return;
> +		}
> +	}
> +	buf = data + arg->field.field->offset;

You also need to make sure the data field is not smaller than 16 bytes.

	if (arg->field.field->size < 16) {
		trace_seq_puts(s, "INVALIDUUID");
		return;
	}

> +
> +	trace_seq_printf(s, fmt, buf[0], buf[1], buf[2], buf[3], buf[4], buf[5],
> +		         buf[6], buf[7], buf[8], buf[9], buf[10], buf[11], buf[12],
> +			 buf[13], buf[14], buf[15]);
> +}
> +

Hmm, I know print_mac_addr() does something similar as this, but this
is getting a bit extreme (too many arguments!). What about doing:

	for (i = 0; i < 4; i++)
		trace_seq_printf(s, "%02x", buf++);

	for (i = 0; i < 3; i++)
		trace_seq_printf(s, "-%02x%02x", buf[i * 2], buf[i * 2 + 1]);

	buf += 6;

	trace_seq_putc(s, '-');

	for (i = 0; i < 6; i++)
		trace_seq_printf(s, "%02x", buf++);



Hmm, not sure the above is better, but having that many arguments just
looks ugly to me.

-- Steve
