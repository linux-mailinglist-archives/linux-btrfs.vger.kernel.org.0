Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BEF3E3778
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Aug 2021 00:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhHGWv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Aug 2021 18:51:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:54151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhHGWvX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Aug 2021 18:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628376662;
        bh=gQ3JbtHiHaNzfq4IVT/wEAB2Gb9JKh9c9mr9DSyGy4Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QCfxXVg/hd1s963bWS/HzWKWRdu6eoIMRUKWtlQbT0J03qIyWiUoxw5lLdB0wSgjX
         P6w6SfKq9XfYo4sf1d+KE7Ni1XnyOzMv4kEAu427nlJEdUZTpaZkA4m15m2dQk22Eo
         ZS78oWKPIvA9Kp/E4jKK/e3oh9qqU+dmsWEq1yj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1mjM4N0qa1-00bqYF; Sun, 08
 Aug 2021 00:51:02 +0200
Subject: Re: Simple question for newbie developer about qgroup
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210807144736.GA2820@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d76a7dc1-b8a7-c8a1-5d67-ce148821a3b0@gmx.com>
Date:   Sun, 8 Aug 2021 06:50:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807144736.GA2820@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ibtqoncHfVCqnb4rXH5rCYqnfRvOQMB8hNC+tHR6spPoPgjnYQv
 AM7dqcuQBAkyBqWmmNVbhLC+RXHRPTjgPHhxzXfHcOvkuMgpOFHhKIsn5JLuXITjVepehNC
 3/AJPom1lSvOO+ryO9KD4tItWVjaxsF/WHqTR40u6zcgd3DsgOp9URr6AKlNJbKfnx8fVsz
 ah2hA8i7g3f9ZRJi4ehYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4rMDwurqLM=:QzF5sun8OdXn975E++XjwZ
 MY4JmaRshzDI5K5wekjzdReqHhtyHt9P5VIoTnesmwdyew20E5I4jtNFrMdAPPWUVcb2cpotr
 loCtN5s+OydgW0TYh4T10Z06N4yEHEFnUaPcv5KL93urieuMmO+thBCPrCWq+DPgUyl8X3COw
 MVv1vHiJcHIZ5ktFQx6oyQyj8sN702aweSJkXzQGIM5MrZ2fbmleERQ/InprNZJCyz/0KEGLd
 oYBlkpErTghezZZygwQNSG1YDlN9kZ1WCto16BKAjafgtWF92yYCUBvuH3OI5xKLFVtkZWCHh
 Tv59NwQ4IlY49JLThoktQ5NaGVUZFcyK9MZ/LNG5OshHsvfSFjiLn5K9V9CVokYb2x7ZjSibn
 6/ID8eCe5MtOv46T2LYpyvt2p3u12hGDWyxoPVpluKT8ayvENQ2lb2UpEg9G4r9nWPzoi9ZHm
 ZgMwph77DIArmCG/i6KMBpV6QSy1fz51tFQPewrLMHkNLh3UKYmu7uSLl/0J3MftqMtf07hht
 VE9F1OXT+mOs/OUbpjIkGzrzuQcEsymRz8XBMv6yeyXYWairebXaw+HWEfhvEX9YCBOYAei+A
 oa/D9+76h6FI3Jsh0LXk+HXJ7eFEBtabopiVglbiFJH0aYC9nJ7JWUukYPdSmYLl5TyrRL+9i
 0Ju4miOp1oi8tPEctFg/AYOoKL+8eiHLtCghST1VkqbAxWvAZqkvoJmUpdJ7xWpft3pO9eyBV
 5xaVPNbLLUxzHp5KgVB/oXRgQ5f+ti0Qgp7lQQjmn4r0X1LSx5OA12HcHYU1S8afVDS3qpjzi
 ACE9h/qo2A53+GpGFEWP0NV6rGlXJY/kljaqeaXgz1tHtFF4RPt2y3D9WOJ+bLdTE/r6HQTFz
 rraxDIgF7b7pwHkVisD/2l8Ri7J41eyhOcm9M/a9wT6PQ3+GICvetjbYKr+rzHoA7tEM4tEkW
 EVSFdIGOgg6q2qc75zjVl4SmT/jthEKRnluNQuOtOtlnBpV272/xkEa8aJTHeN+V19+IXwtIS
 zfg8oFymC3F2FHVOuzTMmhYiVKdjlWB9R9dvtNr7Rid4GdFHbIfMJ6AKNzwfzhm9ftRVBQtLq
 6VXcwS9ph36M+c5NWNbAm0SKMLkmH9hDZkiU0pNYFx7q+pJ0HG3MHPmkw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/7 =E4=B8=8B=E5=8D=8810:47, Sidong Yang wrote:
> I read btrfs kernel source code about qgroup. I want to know about how
> works adding or deleting qgroups. and I read the function
> __del_qgroup_relation() in qgroup.c.
>
> This function checks whether dst is parent for src and store the result
> in variable named found. I think if the checks failed, the function
> needs to be failed or print warning message at least. Am I right? Or do
> you have other intentions?
>

User can specify a non-exist parent/child pair, in that case we don't
need to print error message, as -ENOENT is enough to inform the user.

Thanks,
Qu
