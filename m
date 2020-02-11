Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFB159228
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgBKOqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 09:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbgBKOqU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 09:46:20 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A632620708
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581432379;
        bh=HrHoOHIL2qv2IekL9FtJQZfxiLcpkMnOkTbuqWwfWBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J7KkfY2AXS8ifgCTyy/SMNAR17w6HmlZ21lrkmO+Tj4BvUfIHhhf6ybXhYSlIlxPO
         1sUTS33oLZQRNitQRCP2Yp/4ayP/4zhj31WzwyC2Xr7nQHGf0inZPzwt9pATOEKJxF
         cGvtekyc3FI8ohTFvDN22f4FMMeoehcjNfuuh8b0=
Received: by mail-vs1-f52.google.com with SMTP id r18so6433062vso.5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 06:46:19 -0800 (PST)
X-Gm-Message-State: APjAAAVE64Tjb+Ilw+vt61HWuWZpIl6vaL4e1veapFNyc7RQBFp+QUD9
        9GKvvJf7FiNYCa+B+mNTLazLKQok14YHk/8TjYk=
X-Google-Smtp-Source: APXvYqyQNnFZXbb8eXekXdQAzkUw5CF2zvyP6w01hoxv7egLKmvgpw24ncKme1VslNscT7A6C3S2I0UyvIr7qtc21uQ=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr8931491vsa.95.1581432378676;
 Tue, 11 Feb 2020 06:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20200124115204.4086-1-fdmanana@kernel.org> <20200129170953.13945-1-fdmanana@kernel.org>
 <8727d06b4bef8f337dea40c83d3fc4132f721585.camel@scientia.net>
In-Reply-To: <8727d06b4bef8f337dea40c83d3fc4132f721585.camel@scientia.net>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 11 Feb 2020 14:46:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ETtr_DAjTUkrzDY6-OpDJYzSsuWbZnzpR7sDh-WXqgg@mail.gmail.com>
Message-ID: <CAL3q7H5ETtr_DAjTUkrzDY6-OpDJYzSsuWbZnzpR7sDh-WXqgg@mail.gmail.com>
Subject: Re: [PATCH v2] Btrfs: send, fix emission of invalid clone operations
 within the same file
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 2:41 PM Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
>
> Hey.
>
> Just wanted to ask whether this is going to be backported to 5.5?

It's a bug fix, so yes. In fact you can check that yourself:

https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.5.3

thanks
>
> Cheers,
> Chris.
>
