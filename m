Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F741F470A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 21:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgFITXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 15:23:51 -0400
Received: from a4-5.smtp-out.eu-west-1.amazonses.com ([54.240.4.5]:51188 "EHLO
        a4-5.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730673AbgFITXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 15:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1591730627;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=SEXwxRFRXsMpPQTHQd2YMA/cvh8tTL/R2ppldTjQQj8=;
        b=WFFqQ8mpezGzOAYT0OQJ84YyVFE036PWZWGGfxfTg/iPcqqSWVax7XCy2d+3CHsY
        YAnwxdYrueJ9uWEDZgheP7GJ+Pk4F4rTt3Lq9nG6ZQOrNX0YbankBe61lmuQbn3kTHH
        FL1p0VUyNSfH+SR9PYe0HWa7nDOBnOs+IG591A54=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1591730627;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=SEXwxRFRXsMpPQTHQd2YMA/cvh8tTL/R2ppldTjQQj8=;
        b=flHj7i79KS3XbM9vs5nZdfGzoeLD9gL6wVVoWJvPjEBlg3skM5YoN+pbejCDWdtT
        rsAcdXTkJWC3f0M3yricXBA9A6Y0X785o+dstwvAnseZA6C3vN5pmeY+uSwlZMYf8Xr
        e28f3F6nWuDNq0UKiljd/YP5AZHPzwlbM5FBmJ9s=
Subject: Re: BTRFS File Delete Speed Scales With File Size?
To:     Adam Borowski <kilobyte@angband.pl>,
        "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <20200609175347.GA1139@angband.pl>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <010201729a89e30f-803b97fd-3193-4b88-b349-ec6073bc211c-000000@eu-west-1.amazonses.com>
Date:   Tue, 9 Jun 2020 19:23:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175347.GA1139@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2020.06.09-54.240.4.5
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.06.2020 19:53 Adam Borowski wrote:
> On Tue, Jun 09, 2020 at 11:31:41AM -0400, Ellis H. Wilson III wrote:
>> We have a few engineers looking through BTRFS code presently for answers to
>> this, but I was interested to get input from the experts in parallel to
>> hopefully understand this issue quickly.
>>
>> We find that removes of large amounts of data can take a significant amount
>> of time in BTRFS on HDDs -- in fact it appears to scale linearly with the
>> size of the file.  I'd like to better understand the mechanics underpinning
>> that behavior.
>>
>> See the attached graph for a quick experiment that demonstrates this
>> behavior.  In this experiment I use 40 threads to perform deletions of
>> previous written data in parallel.  10,000 files in every case and I scale
>> files by powers of two from 16MB to 16GB.  Thus, the raw amount of data
>> deleted also expands by 2x every step.  Frankly I expected deletion of a
>> file to be predominantly a metadata operation and not scale with the size of
>> the file, but perhaps I'm misunderstanding that.
> The size of metadata is, after a small constant bit, proportional to the
> number of extents.  Which in turn depends on file size.  With compression
> off, extents may be as big as 1GB (which would make their number
> negligible), but that's clearly not happening in your case.
>
> There are tools which can show extent layout. I'd recommend python3-btrfs,
> which includes /usr/share/doc/python3-btrfs/examples/show_file.py that
> prints everything available about the list of extents.

Also there is a 4 byte CRC checksum per 4K block that needs to be 
removed. Mount with "nodatasum" and run your tests to confirm this is 
the cause.

