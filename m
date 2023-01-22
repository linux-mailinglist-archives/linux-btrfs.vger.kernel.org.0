Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001E677252
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jan 2023 21:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjAVU1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 15:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjAVU1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 15:27:41 -0500
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27821714B
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 12:27:37 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id Jgw9p4hwKE9FhJgwAp4F4B; Sun, 22 Jan 2023 21:27:34 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1674419254; bh=gAFCKBppvhokbHuEGyuj26AXWvhsj1EhPShO64KROlA=;
        h=From;
        b=QN71LKicieSSo//ZB8KAvQLT57QItUhFx01A6QUrHgpkUOQKQ6j7rQqQsTnCACH3s
         Ctg1GnWnbc7YhK/E4ym2anMEJbfv8dz6JBRcs9pMKQU8TNmw1JWfxpr9BR4zaZubMP
         a7QjRqAb8+GHcSJJVXMJIXtZf4m+7orDmRvJtdus2YcfRytNgs5ci44Y5WeYP9AAbW
         oFfgIVTWFRC40PiDenez4aO8GAfYTicdkW8ZgVBAVg4sXLbtqbDPbDZGbs9aNjpgVN
         JkNU7zBbKajL9QDw399tzrdcopK+3khpxP1gtRrf5uc57uyr0t5GSXS1O3/i8BYwrY
         O1P6j00KLV+Yw==
X-CNFS-Analysis: v=2.4 cv=VMQb3fDX c=1 sm=1 tr=0 ts=63cd9c36 cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=vUf-GdnMp9FBiyLyoV0A:9 a=QEXdDO2ut3YA:10
 a=sBB5x-0A3AUA:10 a=2C5uJnGsQ9oA:10 a=oIrB72frpwYPwTMnlWqB:22
Message-ID: <c08cea1d-1ae3-c0d1-c164-6453ad73f0c0@libero.it>
Date:   Sun, 22 Jan 2023 21:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: kreijack@inwind.it
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
Content-Language: en-US
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFYkVYec7P+45rMBbYin+gC4Zh1z4+CMfyrqkx7eXEOeY/1EmSJfIHfGiJlNh+sjE8fRKeJsnZIwXASXdEJDFgVY82dO+SLiC9nMho+IIe3hDAbf32dV
 jmoEWkeKrbIbp75DnQil35RIEEEXTW6/l9VE51so5WLObZC2rfITPDBg4xhHohBJgEJzq3Tnm6w+VD8X/SEMktInEM/JArBLPojCqa/0LJCCfU2V+QVWlb8J
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/2023 12.41, Cerem Cem ASLAN wrote:
> Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> 
> The problem with the "chattr +C ..., move back and forth" approach is
> that the VM folder is about 300GB and I have ~100GB of free space,
> plus, 

This can be solvable: it should be possible to make a tool that for
each unit of copy (eg each 1 GB) does:
- copy the data from the COW file to the NOCOW file
- remove the data copied from the NOCOW file (using fallocate+FALLOC_FL_PUNCH_HOLE)

So you can avoid to have two FULL copy of the same file (in pseudo code:

block_size = 1024*1024*1024;
while (pos < file_len) {
	l = min(block_size, file_len - pos);
	len_copied = copy(srcfd, dstfd, pos, l);
	fallocate(srcfd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, pos, l);

	pos += l;
}


end pseudo code)

I don't know if there is an algorithm that prevent the data loss in case of
an interruption of the copy. May be that it exists... We need a file where
we could log the status.

> I have multiple copies which will require that 300GB to
> re-transfer after deleting all previous snapshots (because there is no
> enough free space on those backup hard disks).
  
This is a more stronger requirement; but unfortunately if you copy the data you
will end to have two copy of the data which before was shared between the snapshots.


> So, we really need to set the NoCow attribute for the existing files.
> 
> Should we currently use a separate partition for VMs and mount it with
> nodatacow option to avoid that issue?

Not really, it is enough to do a chmod -C on the directory where
the VM images are stored.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

