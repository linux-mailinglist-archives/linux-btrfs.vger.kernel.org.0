Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2547C577D1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiGRIF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGRIF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 04:05:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4D65BD
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658131555;
        bh=fmImRxVZ1CKMHNKMGyhz481J2MmnPAWlJUEZ+ZuINSI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=drKf1Tp3h5SYc2l2mbFzNgWt1uUUZMWVTeE5kxvbYJ1Y+Z/OL4HjkN9kb07+4P636
         fsMyN73ey+sMfGcCyyvPcE4vwSIp51B2xu82h9OdH+Zia/ByohDk3cUtwPmT5KvuiN
         scxuqQ7E53BxDwzTSPeph5HfXeKpdeX03Gz3pjY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1nILKc3qCm-00vNNt; Mon, 18
 Jul 2022 10:05:55 +0200
Message-ID: <38d342a0-9057-7fd7-6ed9-d9b07bc4c27c@gmx.com>
Date:   Mon, 18 Jul 2022 16:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Odd output from scrub status
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oiHgcoyOPGx7e1feuR+IvoAJS1wgNbDz12Kti2AU5ySoco0rKd9
 /RupW/QlT+thfy8xpIIpE521enqkaz0X6OuoVxWqh0Afd9q+Aa7nKI9A3ZR43VqnAH0qDTb
 LzDsuixwmnja0Y4aJvhhFmtdl4Sl+hZ6Gg2k+z5xSlZCYBkuOw44cSWoKY801Ux5RnRiMUw
 gDl4Mqv5v5FwsrpF28IHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JIM62dCrU3A=:mbSoThskil1VyVfLB22E/U
 sW9jI/m9ikWac8SJLgayU4nwwYJRAZu1oC4tb4XR+iYltlvFXnWBxh5O5ZIaBFJhRWXL6Lp3N
 TDpVBKvW5V8gNJQUrSey7+QOqucWlZusgWjC1yMEYfoFRtAcAcrp+W5GnI/wNVa9Smi7te5a+
 /Tk4IO/o3IYPqYNhzxf52L8j5uQnT+QIVctZqhkhtlfdxcOAT1q5snT0mmyR48N/vqgoPTXDJ
 sh7DRYzP/i060+RpQqjBLW1X5bzLA+c7SfxqXLP6alC2T6i3nz81pw8brDvElkAjIFzIR8RI7
 vnK+bFsYAE8pSLK/ldSXud4t7oIhnypK/wODYPEgHucN7TK8eiu1VhdRw22ooOiAfV+yepUn4
 gYt+DotG9Bb9Znf9NR6IpyvztITWzamgcmS1HwTYn62h9qhf1miKDdOrB/eXdybOBo2jpCzVa
 qYj9xx8Q123rftH0fEB0M1ABSaBCU6mIvd49AalLz+7nPPm8JBoaSow7bi1U8E7yTILak5IcZ
 EO6tJFyz3RgN/N1Mt7y8F2t2j4EMYj9gHKQHg7GQgUT+cpzrL28Se6f6udu6bm4I3IBvHZPUi
 eSKapw5ULwAWmStuWXOXhxIwOLAC7QVMIDPe79O1JT8DlyEc947dK+zKsqXRLejcTZv2ap4Wc
 MNVy6ZxG0pGvQ3A5ERCgAhiDXnqNsEu18iNIzBVu4GZMvyKjJzIHE/Fisx0F0Iwfnwr5Bpx7b
 mVEoiOXY2iB5kHUvB9vi23l7KazwuzGPMUBgEV2qF9BZ3T4IOTOd0dA8W/qstQKmsivGqh30a
 O73X4wAlSt3oQxAsBzAKkUINyK/EvB3BlvskVdFhRLk8Xmw5peh2RG0V5DFLQRnPa6fOeHZ9Y
 hPeZIViWE3+V0JnYCahSXPkvUpfQXE9NocFULKy8a+zhxdXPxI2GFJMH8uTxwLdn2aEWF5ykM
 qtd8tHewKMpumY/ly2OufNiNSE/QKmt0Ggh9h5fGy7hkz2iKnVuwW89WSQ2nwpE1McdFEoOM+
 7Ks3vW4qrKVSm/b4VOq0QAFXg71wpSzKxodA9HKjk4FdpVxm+pgwVllsIJS/K6jlqXyDcRaAl
 BbCFpgmm4qkANiwaRQv6unPobWbA7/CTOQUJk4gVRFazz4tTftsBskIuA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/17 19:28, David C. Partridge wrote:
> root@charon:~/bin# btrfs scrub status /dev/sdb1
> UUID:             f9655777-8c81-4d5e-8f14-c1906b7b27a3
> Scrub started:    Sun Jul 17 10:27:39 2022
> Status:           running
> Duration:         1:59:29
> Time left:        6095267:46:37
> ETA:              Tue Nov 20 23:13:45 2717
> Total to scrub:   4.99TiB
> Bytes scrubbed:   5.48TiB
> Rate:             801.72MiB/s
> Error summary:    no errors found
> root@charon:~/bin#
>
> Cheers, David
>
>
Mind to share the following commands output?

# btrfs fi df <mnt>
# btrfs fi usage <mnt>
# uname -a

I'm considering if it's RAID56 or other profiles causing the problem.

Thanks,
Qu
