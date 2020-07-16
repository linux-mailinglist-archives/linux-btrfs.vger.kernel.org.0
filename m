Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F722219A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 03:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGPBvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 21:51:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:53301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgGPBvo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 21:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594864297;
        bh=ADYCyR5Ui5vG+h//xpftGTE5c6THntiVnVb6gg21HNQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hVBr3c9cJrkJB7R2Evpbg41kZUDwquXgq1w56rMjj+2r8pyiCUTQaMhjmUz1Ha1gp
         uyqEhWjnjd3WevNComQmta8CZ7/3vdRBe1u/FaE0qLt59JZ0RaaNXNGfIabRyxnBi3
         JBLETcHlDbXybUtbgPTrGkdSSjww0JONy/LDNqiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1kCBYb0Tmn-00J0TH; Thu, 16
 Jul 2020 03:51:37 +0200
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     Chris Down <chris@chrisdown.name>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200715134931.GA2140@chrisdown.name>
 <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
 <e6cc556e-c830-fa28-486f-e23d520fe98e@gmx.com>
 <20200716004031.GC2140@chrisdown.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <2340c49c-f240-b0e9-8316-339b69254196@gmx.com>
Date:   Thu, 16 Jul 2020 09:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716004031.GC2140@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/delCq3K5SksTOa8a+B9OVhfZwu9k96Khyw3GDPGD1EkVMfSjgz
 vnKERk1I0DwUWrBDlMZLvsX7SvaS6eb3CG37vV2gUBwoSq62+ppJkSpD34uijCX/uxpnsnu
 9z/bLl9D+JJZwwLPQLvkclpSBJb1ZGwuSJKbOdOB3HqHLtlZnjlNrGbmfz4p1LQdt/O8V0H
 DbA9xpMKRkGknR3yi9gBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:36Cu9Rb+TEY=:uCC7YZxGcYyeQoT0cQavuq
 rIgH56dupLH9sGEFSyXNagx39sd7C7gfuSGhMMG2s4ky3PruEuPRUHNyTnX5klH9ODoZL5cwK
 H3k+BMXwXe1OuvTQYRMBdvBFdbgAf+yfCkGxAmdv9OPk1mNmDL6UmIyN9XA4WGJnIaRZAAFKv
 NVwOw95jDWkoFHi1gycoGgLD24ifMuSHGnkCXQVFJ4jUpVwFIl3NioUjrSRL+T+bxqDl3927z
 fBGk4nTmJ4x/C5l2GbOxqXjKuKst8QX7dximnhCmm6KnnRz00Y3DM73Sm0NQNLsB5JqW41mNz
 tPhtYHVFOsChrkhwu5tedHY/XQTFdKIYFRwGyhvbCEJEtfV5ueS7dsEoy7oh6yasEOv5IzeDl
 3orvwEeuwAdlLSbZlIjG5ZW3j1CVUekVJecNctvM8f/ea4lZueQI9zrinngJyW8+2nG2dyijd
 mXU9fsjqv0YT7lB6BwJD/xMZO4Muh0bLE/Lah5A88PorUbslN7oR0W1AzwZbvea9IdvJHeWrP
 A01S3vmI5PqG9qVwZ8TiA2ihM/NWEtse2uCXc6201hvJykiqZikW/UZW2sp+cnqHPDgBJ9/kL
 BYbNAmiPxczRXS1viW2TZge/F5dfvbTxztL5RhFf7oiJl7yUuJvWV55MDT4GtqrzaDfDSx72I
 f9WpG+vm+1IOa6xfJ0Q8YDKMiMHFvuGKoAeu5kHom/mUH/7vJWfsUwC1YjlN927HvMHUnX0gX
 jdRvLQZDOzl7sun6gyS+kSLpHHlRBBY2MOmZqB1Eyk0r7I2LW6Tx+5OHt+jV0+mE8xJFjtLBX
 srXAp6roGOSZpMSFv9IbwGg/qTR/b1txXfToG8pHvEpiZbXm598XRJa9NghW8V8jMke9EGl/d
 5OlhWDEnKw+1rkUQzZJwY+Li/7cuN0RmDnyh+mYSJTGiR+izshRLgfGWsZBk0OlS7G5jbGnHb
 g2wUNbWvSZddGMPGxYG7vtkcWDl7QST7LKMpYcBZhjP/L3iqbXkYSmUenJ5sAA/MZY1ohSHcV
 r+2oBVcyCSyOVRpBlwoMqpPuQj4bg8vP/jtt1/asQRtRmUcr6wbh8Hn0eQhuVGyp7CodndCDR
 kiwfAfvRdLn/g+ZORrQmc37aFDt7s52Xh/e/s2Z/Yja+XR9pyarzGUfl9BSrBH6YYh0NastjV
 s0w/qS4S79tTspsxxffOElyyhMC8P3p4C77nF7Ud/+0mCcRpwTh1zh9t6koefvXEFdpkp/zDu
 lIuwwMgK0xzlVwCuQrlB4ZmDt2N77F+6Qh19laA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/16 =E4=B8=8A=E5=8D=888:40, Chris Down wrote:
> Qu Wenruo writes:
>> Would you please provide the full call trace (especially the address
>> causing the NULL pointer deref) and the reproducer (if possible)?
>
> I'll try to reproduce it again when I have time. I didn't have kdump
> set, and am not currently running linux-next, so until then, you can
> have this crappy photo that I rushed to take earlier before panic=3D30
> took effect :-)

No problem, the image is already good enough for me to lookinto the case.

And the extra clue of linux-next would also help a lot.

Thank you very much again for the report,
Qu
