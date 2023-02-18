Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EE69B97C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 11:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBRKqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBRKqU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 05:46:20 -0500
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EE1E9CC
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 02:46:17 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id TKjOpN37LcS9XTKjOpVkLP; Sat, 18 Feb 2023 11:46:15 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1676717175; bh=3QKmyzJDyzQofsDDBwoMmomMQuT+Njt0MNIXFUeP6gI=;
        h=From;
        b=JMlZA7cEB1wa15WHyUNZpg/2Ufmxp6iVl6FHIv3P/5u4bQn6MoyEKpHThf8Hggtq2
         6V9MMGIyR6NrXEOaFx681ByG0sXMSXoVFRwp0Stuh2b0hFaBxxQg6a/B7LsPg1bqq0
         mkOziQLG5v0BX4aDSKqhuYyS63aA8X+SspbaLbhJq30LzAqMSDYoy3hBtpiay3KCgE
         D4OJRJyY0uz+EC27HZZpuASinvpNQ1+h/jEAVNN9Mp7PE0NKjSb7ApfkXh7oQGu+Ug
         nVSKi5rnmpMejPCr9U6dQCcxLaV7QexWDZabRaoaJj9voS2SbRr0fBp8ZZyc3mX/08
         tvNup+cGpuNLA==
X-CNFS-Analysis: v=2.4 cv=Vfgxfnl9 c=1 sm=1 tr=0 ts=63f0ac77 cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=OmvV-GpHZSrWfQvEMi0A:9 a=QEXdDO2ut3YA:10
Message-ID: <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
Date:   Sat, 18 Feb 2023 11:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: kreijack@inwind.it
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <87wn4fiec8.fsf@physik.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKgzkoE0DXO8YTn/vgEiBJ6jyAUdDX0QTayGUtYt1TsPeoPfSwW+sPq7eLDsKpa0uT/tQuYiJsLXOg8jHw/uAmPC0aguSIlZQMwXaD0lSuFOuCWhVzuy
 Lr9H0m8mDIF1A6WgexYks33jHElpIEgeaT4C9haWu3S4hZgf+CrUbtCm5E1r9XkOO339PEyM/whUt2rl7ek63XxoN1rwhiMPzG8=
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/02/2023 09.10, Torsten Bronger wrote:
> Hallöchen!
> 
> I want to replace a device in a RAID1 and converted it temporarily
> to “single”:

I suggest you to evaluate
- remove a disk when the FS is offline
- mount the FS in 'degraded' mode
- attach a new disk

This would minimize the cost of the reshaping. But wait for some other
feedback because I am not sure how robust is working in a 'degraded'
mode for "I/O-intensive operation".

BR


> btrfs balance start -f -mconvert=single,soft -dconvert=single,soft /
> 
> This takes very long. I don’t see why, and wonder whether this is
> the right approach in the first place. After all, no (significant)
> amount of data should be needed to be transferred in the process,
> should it?
> 
> A side question: Is -sconvert also necessary?
> 
> Regards,
> Torsten.
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

