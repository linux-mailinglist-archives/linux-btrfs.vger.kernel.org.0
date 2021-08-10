Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61F3E54D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhHJILg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 04:11:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:38099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237989AbhHJIKO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 04:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628582983;
        bh=nKZZRB2eCgNk3CfTKZ2mzx+huZp4FyFXo9RpxfyEnk0=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=YoxsF/FUaPe2PJ7MNPMXhpHF6Rh/ZiBIPvn5MUzvRPaQWzY50nE2qL+V1EkFq95XE
         zSmr3wTloqeg75efefJBaud7i9i2eaabm1dES3jKra+hfvSgcPxgiikyhr4NTyIjoU
         Xc4cGKCPA1T1Ujgmns78jCbMS8sSatSERVlWbtUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdeR-1mJ5TH4AHF-00Easy; Tue, 10
 Aug 2021 10:09:43 +0200
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
 <2da42f71-b95d-4fb1-be93-be9e58eb1200@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Mixed inline and regular extents caused by btrfs/062
Message-ID: <9d0a719f-2619-aff9-a10c-be03c72ef546@gmx.com>
Date:   Tue, 10 Aug 2021 16:09:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2da42f71-b95d-4fb1-be93-be9e58eb1200@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zL++I6O8Al+cDg1Ubixr5KWO34OggdVd5ljOg4myTqeJnysscS2
 1vQBS2NZwjhLTUL8G/gqPrvUC/MAFHONrqS+oQ4FWISLt6ldCEdpv0rBw1ZzvD5scJ2Nwyy
 1SabIs8ThtgZcZr9GJjNzQCuSCs9CfTGZ8MFoonkqOL6UAt2fUPcwhO/3yj/32Pn0a0yBQY
 iP7zQsKb2s30I5GxZchxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xUTiKyGuAw0=:c9qVxtYS3p4KhrlxZ/mGDP
 t3fOuF9em+wwmVe6HjJTgKuZeSTyK5MMFkQxvMUq4Eb78nVfnqdjgjuYZ4q+xi0qp0n5ZwjCW
 Ipw/TnlfjbwOEuF0+vwGruPHlBUy009aOBJXjY//UaFBiiBIpenAi7ABy4uC0y1FlJR2zEtGk
 8vkByCMd6P5UZRNuBGN3SbHa16lyfpbehQz4Dq4UKFPIc+UgFp61wipTXl4+yHqKn704NEkm8
 KlonITrW+xDOJ43Fs+UcFMAf0kUh/GzQGdK5WZARQ0NSgbNRG8ev8wHa4A6nUfn7m0IzcDOZe
 9Z8jOKT3pjYDcm9phBBt8s9wBgggMzGUXB38FdaDaaXTjp//uPxvw8FKE78vNYb+hzq6g8lak
 Jhoxp5C3fKb8oX1eVQrdKEumThMv3KZFMMWOys16f2eyPLukoXHfbKAkNgJ1uTWjlZsq80K7v
 KOUEmKdIgEOYgpBfUbZ4RGhYZwdJHeOQZR9cVFjbflOhVBjHRda7SWqh9EqE5YrWSTI8r08R2
 hrWX2rvAuGd+cc6UVMsD/87+8oJR8dcWJ2S0kd2RziZmE0azY5EeyEkxngX7FKuTIQ41fdCAo
 gvT+ZaaeUCXENYwajqStqw30EK39bj0I+pK8kVRPFvSk93i6GFF94r561xZcOuXBnBPJ8J2oy
 sasFuf82Q0G6u5cppq8nchj7gRw9T8myu6W0FqrotFPLaG1DY+AMIIt+YD7YAnIVv8gisP/Mu
 S4IKoGgA2AknbbGs+jPMqQoDsdGcftdNmNnBzcuivwMfBzW8SSZAhpYxi5MSfmBj9Caa+Bxn9
 zDTGeYXnaz5vapFwpny1WdEzmuBN2wwpMCEieMgg3uGHywiHql0nFC1g+2E0tSNwbuVSUVG4k
 zrWLTovOq7jmaVRA5YfeE/9QlIIbE9kstaXb4SJq2hmCbMRgJx1b1rf0q+ohckCD9QZeiGmwV
 YqZT2PwdQiyaVEq2/6SmA8K/qzpbQFTDCokbjqF2Lx5LC/gyGRR9/H39yY5Tal/K5R0YDEJFM
 o9D/xo4ZiFST855/L0UrWRV65YRo/bkw1kGEAKrrCFP9qp8SLX1GTbG3rF0CZoeu0SYllj9D8
 SQLGaVDuGn8a1mMkoUjSl+T1XC2DjqOxLLrF2fSmASHkQ/mo021CV17NA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/10 =E4=B8=8B=E5=8D=883:46, Nikolay Borisov wrote:
>
>
> On 10.08.21 =D0=B3. 8:49, Qu Wenruo wrote:
>> Hi,
>>
>> Although I understand current kernel can handle mixed inline extent wit=
h
>> regular extent without problem, but the idea of mixing them is still
>> making me quite unease.
>>
>> Thus I still go testing with modify btrfs-progs to detect such problem,
>> and find out btrfs/062 can cause such mixed extents.
>>
>> Since it's not really causing any on-disk data corruption, but just an
>> inconsistent behavior, I'm wondering do we really need to fix it.
>> (This is also the only reason why subpage has disabled inline extent
>> creation completely, just to prevent such problem).
>>
>> Any idea on whether we should "fix" the behavior?
>
> What do you mean by mixed inline and regular extents?

I mean, one inode has both inlined extent and regular extent.

There is an old btrfs-progs patch to detect such problems:

https://patchwork.kernel.org/project/linux-btrfs/patch/20210504062525.1525=
40-3-wqu@suse.com/


> AFAICS inline
> extents are created when you write at the beginning of the file and the
> size of the write is less than the inline extent threshold? All
> subsequent writes are going to be regular extents.

But with above patch, the following test cases can cause btrfs-check to
report such mixed inline and regular extents:

btrfs/004
btrfs/192
btrfs/195
btrfs/205
generic/269

(Haven't yet to check the reproducibility)

Currently it won't hurt anyone, but I still don't think the mixed
behavior is expected.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>
