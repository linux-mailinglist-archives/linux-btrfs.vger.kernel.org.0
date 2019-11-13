Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBACFB8EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKMTeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 14:34:24 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:35638 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfKMTeY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 14:34:24 -0500
Received: from venice.bhome ([94.38.75.109])
        by smtp-32.iol.local with ESMTPA
        id UyPGiaEOMhCYOUyPGiFgyl; Wed, 13 Nov 2019 20:34:22 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1573673662; bh=XH1txK1wkE5PA30Y5OvD2TCaVLJo0lU+bs2j/dNeVHI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=uH/3C5Db0HpcL0F0bnaPXRb2KG/HUq+p3EjRhE6fJHg14hr9PyRhpuGw3KESeP+tF
         J3YCD7nFJNZ1Q39/voeBJum8nQ36QDruKWN1jibO9+ccrcQlilCM4QYs6Pp8T+mSpv
         UaM9RZGRXRcE9BYUis8Z0x6PyeDzSNfO5TbLxse9SkXLk08Dwo6s+tSzvv/SpnUdnt
         75SAzrl6c/MZ2Igo/7EXnsJM/92iNoT+eVR9oMnnLbUN7edVOeTlR/AcwDrPf0Efvb
         CKBdVyZv4jSswsAHs0H+ym+QvJuZ5yK4jS+LZLcwrbLt8e5Tx8HWkQ2+2FvT0Sh6ky
         yd+dWII4SSRdg==
X-CNFS-Analysis: v=2.3 cv=D9k51cZj c=1 sm=1 tr=0
 a=KzXHLLuG32F0DtnFfJanyA==:117 a=KzXHLLuG32F0DtnFfJanyA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=na11VygWdLpjmZSrsLQA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Avoiding BRTFS RAID5 write hole
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0JG92D511@briare1.fullpliant.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <793917db-5efa-b385-d9e8-ecdcb5e93919@libero.it>
Date:   Wed, 13 Nov 2019 20:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0JG92D511@briare1.fullpliant.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKywYspF/+8gtgyUpFeIpMrWYt50IH03+Qjcy/Od5qd7kh7H7fSu3DiHuP18DdVOe3LiGRtCznUYx47PmQCvCgbXN8VLaSlbxmEbukY0vJ/fBhR+3q1m
 AVPlk3OJXwXjSAW+DjYZCXMTzP8lxLY7FiTnHEFrjYVkdXBoLLG2N48MkA6DYpsVgY3iEr3kj4ILr/kAY+DrKrA4+BNenhL5pvKEnBubfbBS3Et5gZ2yfDEg
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2019 23.27, Hubert Tonneau wrote:
> Goffredo Baroncelli wrote:
>>
>> Instead I would like to investigate the idea of COW-ing the stripe: instead of updating the stripe on place, why not write the new stripe in another place and then update the data extent to point to the new data ? Of course would work only for the data and not for the metadata.
> 
> We are saying the same.

The main difference is that my solution is permanent. The new data in new place is valid as the old one. In your idea, you talk about a secondary step of updating the stripe.

> What I am suggesting is to write it as RAID1 instead of RAID5, so that if it's changed a lot of times, you pay only once.
I am not sure to understand what are you saying. Could you elaborate ?


> 
> The background process would then turn it back to RAID5 at a later point.
> Adjusting how aggressively this background process works enables to adjust the extra write cost versus saved disk space compromise.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
