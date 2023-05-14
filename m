Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABA470206A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 00:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjENWV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 May 2023 18:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 May 2023 18:21:55 -0400
X-Greylist: delayed 2481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 15:21:54 PDT
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02E9C10D7
        for <linux-btrfs@vger.kernel.org>; Sun, 14 May 2023 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1684101661; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=IvGZZTS+3oV7znVBs9+h3y1Oxh0fhdIWD/yOunfvSX0=; b=li8OWKdKo+yeY
        3SK9yfgI7c/xe23rrwp3Fj+QwGw2RNdrGYBnGAIwZsbpyzT0iIGq2pMj8jdtUOgOwlhFt/fdv8Gbu
        X+cIy/ShiwhDwXkf0KgX7PZrymKCkVPmv7pcyubYB54FpconzKP7FcMohzBBYNiBdAY/QDWlhfXkB
        A1cVCNqyOJdBmpAT9G+znTwtTDsXjEjdWuhrVj0Uvw7/M67pdoFtvEYbiKNdXCgkligHne6P4oWB/
        Mcf8JT6fTVOC0f7xrKCdPexWccUMzl8NNuaHFSXdDcYBu8+xSYA3P4ikwGCbu3UgxSNkOppwD+1Cy
        qcgimP+bku1g6sAuucl8A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1684101663; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=IvGZZTS+3oV7znVBs9+h3y1Oxh0fhdIWD/yOunfvSX0=; b=BnXMlMhMzKZ8ITQzZPT2w6Ye2L
        QOrRVU3KvHsZMULBTmwtTq7moeatkX0NyLMpVPKDsbVdTMn0rF1BDd8WFqsGdLW/KcjM15tKldtfW
        lNUjPOS+SCXioottwnQ2b5II4JK6q+H0VJHhg3JzRS2rTu7I46ym53I4wCwhUtv9upGJ5NggkVx7m
        dM/WefqR9T/vOmFeRCYpR050h2fIa2HuhohwqAb2j8ntkj5GgcNZs2QPEma1PfbUc/R8FdKokP01t
        69mkd0CRWWMQkduQw1VSLrVe71rfd+TO6pB03qtGzFbzlTj3veDXizGgHgFhDk3dC0SWjpINRxVCB
        a/z12ugw==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1pyK6B-00FUFL-1o;
        Sun, 14 May 2023 22:21:52 +0000
Message-ID: <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
Date:   Sun, 14 May 2023 15:21:52 -0700
MIME-Version: 1.0
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/14/23 3:15 PM, Qu Wenruo wrote:
> 
> 
> On 2023/5/15 05:40, Matt Corallo wrote:
> [...]
>>
>> After a further powerfailure and reboot this issue appeared again, with
>> similar flood of dmesg of the same WARN_ON over and over and over again.
> 
> Sorry for the late reply.
> 
> The full 300+MiB dmesg proved its usefulness, the sdd is hitting
> something wrong:
> 
> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=7s
> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Sense Key :
> Medium Error [current]
> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Add. Sense:
> Unrecovered read error
> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 CDB: Read(16)
> 88 00 00 00 00 00 1a 20 44 00 00 00 04 00 00 00
> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
> abort!scmd(0x000000007277df8f), outstanding for 30248 ms & timeout 30000 ms
> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#307 CDB: Write(16)
> 8a 08 00 00 00 00 00 00 00 80 00 00 00 08 00 00
> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: task abort: SUCCESS
> scmd(0x000000007277df8f)
> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
> abort!scmd(0x000000007d5b5b6f), outstanding for 37624 ms & timeout 30000 ms
> 
> Then it explained why the warning flooding, as it meets the condition to
> trigger the warning, a subpage bug where PageError and PageUpdate is not
> properly updated.
> 
> I'll double check if Christoph's patch is the only thing left.

Oops, that's a red herring, sorry. That is the drive that was failing during the replace, so 
presumably it continuing to fail shouldn't be cause for an error?

More importantly, today's similar WARN_ON flood did not include any such line, and the full dmesg 
from the array being mounted until the WARN_ON flood is literally:

May 14 21:25:05 BEASTv3 kernel: BTRFS warning (device dm-2): read-write for sector size 4096 with 
page size 65536 is experimental
May 14 21:25:09 BEASTv3 kernel: BTRFS info (device dm-2): bdev /dev/mapper/bigraid49_crypt errs: wr 
0, rd 0, flush 0, corrupt 0, gen 2
May 14 21:27:15 BEASTv3 kernel: BTRFS info (device dm-2): start tree-log replay
May 14 21:27:20 BEASTv3 kernel: BTRFS info (device dm-2): checking UUID tree
-- Some stuff talking about NICs appearing for containers --
May 14 21:34:52 BEASTv3 kernel: ------------[ cut here ]------------
May 14 21:34:52 BEASTv3 kernel: WARNING: CPU: 36 PID: 1018 at fs/btrfs/extent_io.c:5301 
assert_eb_page_uptodate+0x80/0x140 [btrfs]

Note that the `gen 2` there is from at least a year ago and long predates any issues here.

Thanks,
Matt
