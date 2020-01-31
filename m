Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7414EA6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 11:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgAaKE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 05:04:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:33151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgAaKE7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 05:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580465088;
        bh=hQz5nMZR+CvT5McWtOYG5v1HkLwJybet+gFAOFPIKVw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N/22/2QhNhylsvrqpiU3HdCXqmM5GRONZpqp9nDidFoXt/Rdhw7mZEBJ8u5yD7uck
         aye3/nsubDc8js62Ql8/nHpijDpgTpBFjfTD5qqyptBOvi2OfBg2flGSKPDgkrS3jO
         WLHkPBmEEsRaHyQy4Q4Br85+95vV9vdfxvPgRGeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.111] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1irefD3Oer-00CPVH; Fri, 31
 Jan 2020 11:04:47 +0100
Subject: Re: [PATCH 00/11] btrfs-progs: metadata_uuid feature fixes and
 portation
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
 <2974237d-ea96-bde8-bc48-2cf8bd6a375b@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <c6ceaa56-f5db-54ec-a2ba-130d469ec992@gmx.com>
Date:   Fri, 31 Jan 2020 18:04:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2974237d-ea96-bde8-bc48-2cf8bd6a375b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oAb/FmphSBBAu1yEOfSu5x+23h+a6/jLwv89znBuJhTJ8rBFVSB
 L4/o84yvDEH6U5C1F0ZHBlnAYxm5wH/DdchUOmB33IAHwctjejOZ7vf8Bi7cPXSBtvxGb9u
 qUl//vMeeurlsSngy4eRblE+dLNAxKl0g/SFGH4H8xoJEF2su80nOf8pzEJeIGMfMwn7Wz0
 CHfy5vpfcBnfg+C6tqz7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Te9Lfq+P5lM=:P6htiRgnTJDYSI0n3SyGF2
 F9idn+YPLcUqT02abGdtxEi86b4bRJPtRNKeGFtyabWGcAXLX003Yt4bJl/t1Ifzsg6gLOE+O
 CY9grhHebxhQFw/rqE5H7dkLOFrAqjb0n77BHqQEmr3aEFkaOW318FbiuGk5y4St1NpZIrTvN
 AFtoXP2OvXPD/OJJvB1Fxx+8S8cpIVuFwaSSu0txunMhF9D9Q/UrzAryj4bkO0hGPd3+JtFM7
 ofK4VfMH80E5U/0LtPAEhswf+aoOxleptxKMiWw/vI0MKwjw/PuzStR/rnEQwFOUX/6NH8r73
 NVcI+A+HSl5Vo5/VUTXCA6mycACOv5drErqMrOhZD/MlYCDWAj3lzfv2Nin+4STw/JR+7S4t/
 8hrggD57OkwjCnEv0rrPlcGyN+1D/aIc67PpQG6HUxWAQchgRVEFZSJfCJmr06PrJNGmr+UpV
 be0UZhDUQ4ru8z/0DUplfLJpCP7BJAlA40P35d5TV25CMdAHhYBbYsti+RrK+OoGZ8V1DgtlR
 UGupuJCGNAzKYSjhaLI7Ak0/CLd9qZYTZal5AGpDVMDKk2d9BbO3PnijfPH0H9dBk53Hu6VTo
 9ogmbJ/cZ9vDASn7zMGGGJxTQvhmWYeJksh59owo0tTwsk5sx+HMhxOgFUQRitpc3laOQ5B6M
 j3MskfCtAHkpMSzWeVdU5eQdhrV7ZBtOLDso+M8K5Qr7AeNOrb/ApXnOacf90kge0077xmShX
 eGvhpZfJzKlW0/BCOmWgkYfcaaEbPa9dP/IlBj4w/XMt04dy8wAQhe3cQRs/DqDTeaGLbyOVG
 taEXxqeFYYh6tWaMutAqUGkfxY+pNbxpaMw6L2ltJfxVaVXNZ7Ap5lOdpHVEFbXa0IqKaK18l
 v1vWRwdEvMHnur6pbbD/NI8W8nh8IRVlX5vawpdNKiOGInOLp7xK2Zh8bKJduMNKvFsCSX1e3
 /2GbWXyg0Y7QAq5wvURbKUC3yAxROoKxsyYib1Eepq1ZxYqmb5TX1nBQVY+E4QSZR+slBkz3l
 mTv0VUtOW9dGQXvW2As5p62MHYIgQ7ChnauRE5sjO+N0v5IEN7wnmUYx0xrfW0Sl+1eXRZSHp
 Ky+8qcxO49H28RfncVhOtOakhXlMGSPE8WQ9Hz0pLa4rdp4UvKvpnue8wo2QUODLAfg0zK3M/
 iQPu/E/t6X+u29btunbaEvCVocekpt/Jsce6Rg4ANvZVmDiargLEf1Y2xyjAa8IvJSwZd/MHw
 8gqVDn+s1P5I9alWq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/31 4:05 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The series are inspired by easy failing misc-tests/034.
>> Those patches fix misc-tests/034 and add new test images.
>>
>> After portation of kernel find fs_devices code, progs is able to
>> work on devices with FSID_CHANGING_V2 flag, not sure whether the
>> functionality is necessary. If not, I will remove it in next version.
>
> For now I think it's best if this is not added. Kernel is supposed to
> handle split-brain scenarios upon device scan which is triggered
> automatically by udev. If the need arises in the future then we can
> think about integrating this code in btrfs-progs.
>

Okay, so drop patch[3-11].
>

