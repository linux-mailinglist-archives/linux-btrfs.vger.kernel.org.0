Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8240518E7A3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVIeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Mar 2020 04:34:11 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:33327 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbgCVIeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Mar 2020 04:34:11 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id Fw3bjt71oa1lLFw3bjztI9; Sun, 22 Mar 2020 09:34:08 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1584866048; bh=GXWmhSS3O6XLw62j55lJ0/g0BQJ4jSS4mZcQ4kYxcd0=;
        h=From;
        b=gfQVP74e1FtLXhWggZbwJq7CK4HJ/L1YjTc8ADO5eSn9fNMZWlyl/9N2Ec/l8xY1m
         pSVLiWlQ2N4tOfG6ffdfGHODzV/WpFGlWsvKvM/TVQmGErid8s4iaAGSQrtGTPWhyG
         +2Z62IwgWfMwUCQjm4dtTfyjnO7UjY+937IW1WWe2/8qHPaxF54lVD8/PPAxp2yjBI
         95C4uXdlraVvkw6Kx0gXQdqDEHzr+hvH2gDIJiltDJujt63QtNbyN531wRFgY1LsTs
         iaor5TleBOstyrHTGNy+8pfMB7lZOPqi0sZtZD6j72MJh5Fp1cyGUukm03IyDsJm7k
         Gn3ATWriWkF/Q==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=6fIKVRZl-Jdao0fNtgkA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
Date:   Sun, 22 Mar 2020 09:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200321232638.GD2693@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA1nHjAtRhCAmdHz2286QIoSpNtYySAwMqJn6wUJ2tXpiaZ2tiMS/uchUcX334TH1SaC/6vN2DidRSF24z/C0uzAE3Nr+01gD95DWNf5Y+vma2BEOG3V
 KRn4FcDdMuZRFxkT3MVybghZjP/1TuWJB9PAcP0bpbqwVkjRk9ccR6/6p+HKg3/2VECUwxFczh1wa3KG8w+pfYZywA8IeQq0u1cYBq4iqL/0nshPpT4plg7b
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo,

On 3/22/20 12:26 AM, Zygo Blaxell wrote:
> On Sat, Mar 21, 2020 at 10:55:32AM +0100, Goffredo Baroncelli wrote:
>> On 3/21/20 4:29 AM, Zygo Blaxell wrote:
>>> On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
>>>> Hi all,
>>>>

[...]


> ...but now you are not running conversion any more, and have multiple
> profiles.  It's not really specified what will happen under those
> conditions, nor is it obvious what the correct behavior should be.
> 
> The on-disk format does not have a field for "target profile".

Ok, I looked for a confirmation of that.

> Adding one would be a disk format change.

Yes but I think that it would be done in a backward compatible way. I
think to add a field "target profile" in the super-block. The old
kernels will ignore this field, and behave as today. The new ones will
allocates the new chunk according to this field.

To me it seems complicated to

Any thoughts ?

BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
