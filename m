Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EDDEE7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfJUN42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfJUN42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5424B205ED;
        Mon, 21 Oct 2019 13:56:27 +0000 (UTC)
Date:   Mon, 21 Oct 2019 09:56:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Message-ID: <20191021095625.2dfe3359@gandalf.local.home>
In-Reply-To: <20191021094730.57332-1-wqu@suse.com>
References: <20191021094730.57332-1-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 21 Oct 2019 17:47:30 +0800
Qu Wenruo <wqu@suse.com> wrote:

> +static void print_uuid_arg(struct trace_seq *s, void *data, int size,
> +			   struct tep_event *event, struct tep_print_arg *arg)
> +{
> +	unsigned char *buf;
> +	int i;
> +
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
> +	if (arg->field.field->size < 16) {
> +		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
> +				arg->field.field->size);
> +		return;
> +	}
> +	buf = data + arg->field.field->offset;
> +
> +	for (i = 0; i < 8; i++) {
> +		trace_seq_printf(s, "%02x", buf[2 * i]);
> +		trace_seq_printf(s, "%02x", buf[2 * i + 1]);
> +		if (1 <= i && i <= 4)

I'm fine with this patch except for one nit. The above is hard to read
(in my opinion), and I absolutely hate the "constant" compare to
"variable" notation. Please change the above to:

		if (i >= 1 && i <= 4)

Thanks,

-- Steve

> +			trace_seq_putc(s, '-');
> +	}
> +}
> +
