Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38450348621
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhCYA6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 20:58:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:39209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhCYA61 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 20:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616633905;
        bh=hO8e5A8B/Vut48ZPBZ9NvEDZzB1dwaiyt/BIUcDUVq0=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=jXVjC20uU67yOsmdgKT1ttAsJfYzVC21mRF2KQ9NBT9MnrwBYm6jbc2GXYemBojdA
         IvtGSw0E3LOMY7R85OGkok5EPVamd6eWQ6udBa217AbSTVUlouVy6AKU7yl7LbGZvF
         4ujT4IpPfe5V9XYIaaBsIJkqz4lrvs3Z1k14f280=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1lWdNV2ykf-00CUMl; Thu, 25
 Mar 2021 01:58:25 +0100
To:     Jim Geo <dim.geo@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAD9MmSd+Nt3OWA-A2TWZ3hBmDOo0D8YMSk4HWwnJpEhpUVzYjw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: thread_pool
Message-ID: <e50036a4-cc39-5555-3f09-395446a1ae05@gmx.com>
Date:   Thu, 25 Mar 2021 08:58:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAD9MmSd+Nt3OWA-A2TWZ3hBmDOo0D8YMSk4HWwnJpEhpUVzYjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WXIbo5G3pW0321tVn6X6SVo+4t55vCqaAdGOsTlNGgpO7A0UDFy
 c+nTlCN0mXfE0c+et9KX0WqBhUaS+FMuryaatSw+biHy8kJPxG81x4hfAQkDv3cnfT7SnTY
 py3ig9v0l/lL54vWgridUSYjYBswZ6Vh83f5dyl5i55gzmfKLLDFqC1s2h7z+ekCGccfXcN
 9dO8QXWYPBD/DQiHrrcZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+8SnW+vlOI=:bkkSvcByN4krBthCt6Ksgw
 cIRtqVfTWJ71XxF+ncFw8DwSg9ytyF3G2TEv5CGZT0uT87eoorD0ETgL3Dw8VulwFKHtJxjj+
 rfPcBSbscxK0JvzK97ndBa7C7BJ4H7wRsuLq52923lW4LjzTMIis/TygbMzio9nk+IyINifU+
 XRP0ETjhRbgxHKbt718GbIt22pYKEYU9dbbru6pjVimlLq3KplMip6R6eapEKNNyaGOPHRIb5
 l0bbaOBAHeSmKq4uCY8HEQ3fg9KpXZSo0yzhPduneQKsZ4OnioMjFy4JS+bO3Kg4Rk2a/L4aX
 n+eag7Sg78sPL9/yMBrT1uswn+UkzZy0zNHlyanrVAsSFsZGGuaL5MseDs6y/CjcKa8U+9EJE
 f0L10SnHYizC6uIB3BorLCED1mikpHraQCF3jkAqZaVPrioSB1MtD0ufjV98YYMIo7XJx3TPj
 oc02xtvQvjFONPjncp1nBcxtBBtg5sKJ2AWUPikPlMkJCGAlyb7LQfvClhfuy6tW+dNf8MSs/
 iFonzcVIVXfmc19G4YR/h+CEV+vxyjVoF8p8rUx+mUan8ljOnwp32uIH3YO3839+1FLdQfFH+
 boGzR62v5ZKTqG3o97PPuVbsSvoSQbZQG+p9pIiG/Y2jBQbfagFA5VUxdr77O5HqDLvb7uGU5
 JBr7yrnxrjbXGtPtq2wIVJ6tgh6u9Mtez09NIKm55zYMGQ+vb7syAS/vcdJLPiml56oSyIrVQ
 y4/+RTPOAzqrjooPpXTWdpuGQ3D3+jNGUczuJJuJBG09zuTcvLB69g+TNRs9+WbfPz15uceHm
 vXgna2IpO08rsZiRpNccmaM4Et2qfpyUhcfcXpY5ILz5h91N5ILzX0Xe0Low4uyiW/e65e4BG
 AA/84XPmbuR/YqI1482Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/25 =E4=B8=8A=E5=8D=882:09, Jim Geo wrote:
> Hello,
>
> Could you please elaborate on the relation between thread_pool and
> physical devices?
>
> By default thread_pool is scaling with the number of CPUs. Does the
> default value make sense in cases where the physical devices are fewer
> than the CPUs? For HDD? For SSD?

Btrfs is using kernel workqueue, while the thread_pool is just a soft
cap on how many works can be queued to workqueue, while how each man
works kernel workqueue will really spawn is a different thing.

Furthermore, the thread_pool value only makes a difference for csum
calculation and compression.

For most x86_64, the CRC32 used by btrfs is already pretty fast thus the
thread_pool shouldn't cause too much difference anyway.

And for now you should be aware that, the thread_pool is not really
bound to the number of devices.

Thanks,
Qu
>
> What is the relation between user processes-> thread_pool-> io
> scheduler -> physical devices?
>
> Does it make sense to try to optimize thread_pool value?
> Man page is very vague on the effect of this parameter.
>
> Best Regards,
> Jim
>
