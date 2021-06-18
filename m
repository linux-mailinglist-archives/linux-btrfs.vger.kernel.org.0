Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA283AD211
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 20:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhFRS01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 14:26:27 -0400
Received: from a4-5.smtp-out.eu-west-1.amazonses.com ([54.240.4.5]:47221 "EHLO
        a4-5.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFRS0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 14:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1624040654;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=p9XfkccGX50dMzS8kewCwdyTJ53M0kMEtRSfOYqaPJY=;
        b=SBRORhXlK8pcl7N4Ns3xCvqRzR4aS7E9LBhFvMM9jU9SgFt029Mhwiedq4wDCpII
        uQ8wvrQjFb7x4kW3I1cYugIVxsJWLCAcjTkVjihjYv+ZhjMWe/K6ne0/BBfsraz4KBW
        eItuFUzHkf1RdvHFxZZQoUfjF17zpzWFsqqAlMBw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1624040654;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=p9XfkccGX50dMzS8kewCwdyTJ53M0kMEtRSfOYqaPJY=;
        b=V/+kB6AobfK9LGUqMOwfTkROOoF6tBjSUsFn7hUvik9lRETm2IMv6GNj9FSCV7dv
        1u4v3c2kMn+2KldKqpEZK9jQr8zAhkmNjUFQ+rmCRV0xR66alCLZU/WyGrYLs1IsKPM
        /FaOd7EkfRedyBDFs4welExL8h1be+UKBnWkp21k=
Subject: Re: IO failure without other (device) error
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <20210618223652.4b701f9e@natsu>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017a205dc566-00d13158-2628-4660-a27e-306951ca5763-000000@eu-west-1.amazonses.com>
Date:   Fri, 18 Jun 2021 18:24:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210618223652.4b701f9e@natsu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.18-54.240.4.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.06.2021 19:36 Roman Mamedov wrote:
> On Fri, 18 Jun 2021 16:18:40 +0000
> Martin Raiber <martin@urbackup.org> wrote:
>
>> On 10.05.2021 00:14 Martin Raiber wrote:
>> the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that
> Not entirely nothing, in theory the number afterwards is the line number of
> source code (of btrfs/inode.c in this case) where the error occurred. But need
> to check your specific patched sources, as if you patch Btrfs code the number
> won't match with the mainline.
>
Yeah, the line points at this in inode.c:

    ret = add_pending_csums(trans, &ordered_extent->list);
    if (ret) {
        -->btrfs_abort_transaction(trans, ret);
        goto out;
    }

and the only thing that can fail in add_pending_csums is btrfs_csum_file_blocks. Which is why I said it points at this function.

