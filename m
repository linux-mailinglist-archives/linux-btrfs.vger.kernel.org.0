Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4523B4A68E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiBBAAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:00:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:54809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbiBBAAv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643760049;
        bh=NhP6PG9OqVj4irQ4qvdhW3gwBZoVT6c8gPTefMcl3hc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DlCgbONqGPYNqra7lBrFdNYKT7hJRLae4tiAwAHFSGtj9m08ti9brXp5/xM8AxutW
         AUjgNU76FBDYKkactA7tgcsbBA8BVB3qm2OGZrR/+IEjktZadk/IeJiFOz/iBylb23
         8SdHU8+AXeZT60UXS0cb0MUv5KP7+mOUNDysOp1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9kM-1n0nSG24DM-00GWPd; Wed, 02
 Feb 2022 01:00:49 +0100
Message-ID: <7076a72f-62d8-0f4a-6a2c-3885b62c76c4@gmx.com>
Date:   Wed, 2 Feb 2022 08:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: don't hold CPU for too long when defragging a file
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
 <20220201145304.GP14046@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220201145304.GP14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SCRqwiBvtwsBIgK1it+HChqMK0LjYQ9x+o7hgNuIFPKb6Jmb/W8
 cRC+1/foYSp28X63O1MdWU1sDxM+Pp9Pv/8FU83sGVG6KG/Z6kSIfCb6YE7pmA+OJq3yQop
 hmdqWeIMUimJhXYXfJ6OZKzXuUawQhqdJ+Ji0HooY7SQdb2eqJpZEa+J7rEHP3sabSwaGp7
 /7m0TT124SU0r95CYXQAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tcFgHtllxmw=:LtpZAGM6HZomm+wkjlAGRf
 PS1pK6fkMVZeVBeGywp4gPIPWwAdT/GaiX+Oj+BzLa1VJ2JGe1w3HOonQOT8hNIPAaRsepGVf
 RO1eg+bqHNqfybPvExuKwOzwVZe+C/PxjgJH+im7XbFM5H936RjR5Cw1zqZBaGMdYr0jShWfQ
 iiuNWzB2VwVvQuT0pVFql2TWZ6B11OYR4nRllgfmfzimK78Yh3lRvfR2oXsZJyMnt5OI4xDke
 sLTmLvpBjdsxh3+AWucOV4DFtjxDaeOiEYzJNlTDtg/QZqUiKbRlFxLh2CYR9SIzSLZLVgSeP
 Q27KXT/pLuNALR2ifch/BjX79K3+dA21NoYQL6iu0E/Urz2AKBS/CDHmC/oSoOmpcJFSVs7nB
 jXriqsFl3pGzGCvXkcZ45J5bB5joP95y4kvi5MFBQ6KVM5LTpShfMuL7cBdbAKd1P+W94jGIK
 izoNyTtiSCYmhgPvvYfLPoaplimxdizqhvgk4zICFn6uEz49Q4sbLc20HBw4Iuo43tMwEz7i8
 3DQYiZrleO/lHbehx6jRvDiNPrLmcLu88hbioIV+7txKBJcPSLBgH3CQVOJ/H5jh0dZLkz3ie
 FBNLJkvJ6+OgKzOUF302idVNaGq23G2NtgJwHi0w74PKMBF4IflEUhXc6b473FQ+ZiDmDLMP0
 g+YkQyN2vIS2LZ3irqBrWyE4JR7eNruyjebxD5WI3xoeffXeQAhjxaS0lXhWLyMGWwrCGiPWT
 yq8vqRKiFBosURf4+Z7MCFwjhvtnD5Yi1qUZUuZQ/Z2aEXS6Ql1IqtbIkFM4uKJCAK4hoMzVH
 26GHIormWuxgiEPsr56dQxoBCPXsQEZhclZwGCZ8HK3ArW3fL2s9E4hcP/VMjIfcz686drhZD
 kJEOwEE3g1+peVk2kGuA4GyDulXp5foGJMvuB0tSzpM1ijtpuhVaN/VrpcTI7GqNpdraEDEcQ
 +OPrwSIY5aXCWGB+QUAGqiYI9v+cTA85ufgFcwoyTqOHm7ayf/HdXuHiRlWurp33yrRzN21qH
 xMSMRxSF4rEWNlm/ubngsVOuWoW1Wwflqcs1/ImMO4xDN9wi9UE8577iw03V2XSZKwwXAvk2w
 u7KlyqHJy67p9A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 22:53, David Sterba wrote:
> On Sun, Jan 30, 2022 at 08:53:15PM +0800, Qu Wenruo wrote:
>> There is a user report about "btrfs filesystem defrag" causing 120s
>> timeout problem.
>
> Do you have link of the report please?

Here it is, not really a formal one, but just mentjioned in a thread:

https://lore.kernel.org/linux-btrfs/10e51417-2203-f0a4-2021-86c8511cc367@g=
mx.com/

Thanks,
Qu
