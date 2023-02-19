Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E469BFEC
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Feb 2023 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBSKJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Feb 2023 05:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Feb 2023 05:09:26 -0500
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062CB1025D
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 02:09:21 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id TgdCpT6iXcS9XTgdCpYNcA; Sun, 19 Feb 2023 11:09:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1676801358; bh=ze2LS7Lrfa7DUUf8ggXydRNDCOvIUenD0QXvOCssH5I=;
        h=From;
        b=U1c/QwIu813h/zQ1YXwmk42J6RIFr9HOXtcIeSAQYcImx2m/WPl/1YvPaTw+jh/kW
         gPBAsjpPmvrjOkTrNlG9SZpwiuwazLXajR4v/gyHQzHmpMFp+g6473774iolGueNKb
         P1v9c4U4f4X3PPiriDjJBylVVLCIq0jN3PwdpQIHZmspWV1524luh1dZwFSyQMFovc
         SjGePRKxo2pa06ZeAwVacDB5JUr4EURS9ouViAyuWiOZtvFr/uiitz/xIh03xLNcbt
         nBUbVN3YaHSaPLf10+XvBHqBqkfuv0Hji0xilbI+s6ev9vk2wMq5eIH4WU5iljTg2k
         fp4b1lW8JUw2Q==
X-CNFS-Analysis: v=2.4 cv=Vfgxfnl9 c=1 sm=1 tr=0 ts=63f1f54e cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=LMEublByacrduUguI6wA:9 a=QEXdDO2ut3YA:10
Message-ID: <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
Date:   Sun, 19 Feb 2023 11:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: kreijack@inwind.it
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
 <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <87a61bi4pj.fsf@physik.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOWAq6GQylODNyCyjDjOQf2sxrdXGs9vNXbda69am9EnDbv59jRXDO05Dq9TCv0VOAKZePrcOaMo4ImPEW+U6ozeIAzZfVaA6U1ggT8s9v01y+ewGyev
 IyinC0bvEeMbzbo+PKlTWIKjhyIn5uyyPBvJmn6ZCX4IpcPXSBYrbFLMdnJ2i1+8kj9tv6y7Iu4q0eF2qNvbdWUCQgl8lq2lY8c=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/02/2023 12.38, Torsten Bronger wrote:
> Hallöchen!
> 
> Goffredo Baroncelli writes:
> 
>> On 18/02/2023 09.10, Torsten Bronger wrote:
>>
>>
>>> I want to replace a device in a RAID1 and converted it
>>> temporarily to “single”:
>>
>> I suggest you to evaluate
>> - remove a disk when the FS is offline
>> - mount the FS in 'degraded' mode
>> - attach a new disk
> 
> I agree that converting to single is not the fastest way to replace
> a disk, but the safest AFAICS.  It is the boot partition in a simple
> home server without monitor or keyboard, which makes mounting as
> degraded difficult.  Besides, you can only mount in degraded mode
> once.  If anything goes wrong, I have to rebuild from scratch.
> 

Just for curiosity, I know that the BTRFS RAID1 is not the fastest implementation,
but how slower is in your "I/O-intensive operation".

In theory the differences should not be so huge

> Mileage may vary in a more professional environment.
> 
> Regards,
> Torsten.
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

