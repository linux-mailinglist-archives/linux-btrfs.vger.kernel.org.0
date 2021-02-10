Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11E6317456
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhBJX0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 18:26:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:36019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhBJXZo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 18:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612999445;
        bh=WyIsbrApt8EwMqUBQXSz6BdaqsYOFwpCJ7WSlnhvMA0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VJKnRogLrr0uYRCeGtzU5YyeZiiMLF/ch4cHHedYl8Xip3VLvI8mJktOqTaYBEN1H
         Z2qMQqkCLELcV4b3Pw1k5tbZK8ND2o5e3FjZC+SBgn5tTCbofTjfSoP3FphXwrReyk
         f2p64oK/QqGE9nf4m9KtAIkTYbvclSGyNiD5ljl8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXuH-1lP0l113EN-00Yy7t; Thu, 11
 Feb 2021 00:24:05 +0100
Subject: Re: [PATCH u-boot] fs: btrfs: do not fail when offset of a ROOT_ITEM
 is not -1
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Tom Rini <trini@konsulko.com>
References: <20210209173337.16621-1-marek.behun@nic.cz>
 <40e38323-0013-6799-1527-02cbac8dc93e@gmx.com>
 <20210210020549.6881d90a@nic.cz>
 <0acf2948-3a13-a2b8-d480-7fc2af1bfb8a@suse.com>
 <20210210172144.5136d23e@nic.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c235e1be-706d-55e3-74fe-bdb2e586c930@gmx.com>
Date:   Thu, 11 Feb 2021 07:24:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210172144.5136d23e@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4OLSJZxXOnkskgK7XtSVzBNA/ToP/87g/v5uJ9sEnQZ/hfBlrHL
 /ulQO+LuUKxwbMvD25nuAHOTM7cJl2OedJ5EBkaCermXsIm/STtZkqUx7js0WJcm2i0sXhm
 wbgW6zIdsodxpp4CtSP6XUihN0NhIQBBOecuJ/Fx8aMHS3uhUIPjiCqW/Ddbnjctb3COp+t
 ztXiyX7CrZZKGGofS0oMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yeQPLiPh0jQ=:Co+n27xCr4r0N5cWwoBJDR
 owvAfpi5rwByx28GNb6WmXDg9kcXsTWOxBMKiJ3OKIhtDnTdss/W3tJA7vmvD4GqH7Js+NRW7
 HMsK0T9DR1KcBJyyY5tCMxfQesrbeuBmvDBQgz/SI7++Wzs7VR3niF1z3XE72mdCFnqHP2Q5Q
 2FR3tF1jKS6zbvuMTBrgNeGfPjrJ2pkq6sLUnGXPlHdox0YpGPhVaRlqdDYgyyWvymuFO5BjX
 bFBNKr3JW2z/ALXu/lbmIz+aaf8HFVkwGwlNIIdbVLVduw9Lve1TsHvYdWwf4UJRdjj41/gkA
 v3D9A+Z3bydZ5eBjqD+Y6zbEb7mctaI2gSy/NnP9pXM9cyRVwt/pIrY6tSnIVpONno3zYyYIa
 qGQcAwv1orZNU89JmEo1b4gW+zYmcaTfbQoJBkFjJHWKwjjNSXnDGLtHXu3qZ5DP3WNnC6sS2
 +MxX5gPsGxsVE4WqO05OJdnABtsNQSTEXPp7gwFFz15cmZLqrxF2pPTlMvjTWkX/zjt1wekXk
 02z0Pj+7DVtA+K+ViNQwbAY9zriTiRzCiLbHLl+lfUmn8DBYHphLMyyt/WOL4tqd6/CFgJsJQ
 0k9/qKGVrhPdbKK+2WUz9PLWhssKnY0/TuTiHguhZ2gQaTihSZa3nb0dq5Se9NK6D9wLP4A3s
 0vIVmJM5bzuarCbT1n0oLIDsWOwFb4hk+3J27KyEfbYz44Pmrn55/mO4DLwU6wJ0t212QdMRI
 R804lLF1BvrUw50UyeChaFNTsjeRDZxfs3W6n4N96lKkFDVGDT4EU2mpuSLrdau0wuGZZgrg7
 crbhbU0uP8wYfEFl3BGct234qv+O1BUs3cCz37SejN7w5bPWWlVnBl+vQYcy60WPS/ruV4lkg
 U5x9/SMUxTYEJ5EM7bJQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/11 =E4=B8=8A=E5=8D=8812:21, Marek Behun wrote:
> On Wed, 10 Feb 2021 09:20:11 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>
>> You're correct, the kernel is using new schema, btrfs_get_fs_root(),
>> which only requires root objectid and completely get rid of the
>> offset/type, which is far less possible to call with wrong parameters.
>>
>> It would be a good timing to sync the code between kernel and
>> progs/u-boot now.
>
> So do you agree with this patch? If so, can you add Reviewed-by? Thanks.
>
I mean, to change btrfs-progs interface to follow kernel
btrfs_get_fs_root() schema, just pass objectid, without the need for
btrfs_key.

Thanks,
Qu
