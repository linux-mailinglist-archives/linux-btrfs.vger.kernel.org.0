Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4609133FD49
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 03:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRCf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 22:35:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:50153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhCRCfY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 22:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616034921;
        bh=GYuVd+UfLFAkjGWxaJRMh8t6LVAgNsZqx/S/5F/dH74=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BvE9v9jJ0TzVLw6sBQVXRbVOxsynkij7Og01UmZvYA7NbDcZH5UUl4JZm4pRt+9i4
         j//wRMHYLDCS94Dc3NhKYLvJvukigJ4tUHLnMTza/pVC+6w6nznyYT+Q8TfjKp3auT
         5YTWW5nv2H2cI4Qyi8Ej0qfEjz2LVT1VQkFkuhNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1lKUW903Oy-006fL1; Thu, 18
 Mar 2021 03:35:21 +0100
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
To:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20210316132746.19979-1-realwakka@gmail.com>
 <20210317183647.GW7604@twin.jikos.cz> <20210318022208.GA34562@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b934da96-46f3-ce2a-e9a3-939f40fd4d16@gmx.com>
Date:   Thu, 18 Mar 2021 10:35:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318022208.GA34562@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EdE1Bd5yfBlNkOXJSCMowv7fB3Oj4MHtKpeJsjuTCfN2hf5/pB7
 lGiwxPgtpMqnwp6b89galsaELkcCIKnXQfCn9AZpbKcb83UEWu+XeWXzvAeCoQhw23a7S9v
 0ImSQIoMRy88BARSjGvCZMAhaMYlUpTHCFzfr8bua7b8VO5oIMGk5o0h/yCCkRT1JSXaPJB
 AOE/mseeVdNy7WZ0EcYPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:suLpvrCIuoM=:UvMzz3kfVVg2pbk4Y0ssJg
 6DO4Q2G2VdMj3Vm1nrRD2CeNGpoOXWUB9c0p6t1NR+qpdQPT5bgZeE/oQk0UfsIaLs5K4LF+n
 vhi01AgJBcnBlW0kxx2WdVcm8P8/IbkNxcpcozMnUmfvPqD6YFBEyzRDl6QYYHsljZw9SRGaz
 HCriDbErzchfNZCP4BBgv/Kcd4ZHcC0ZXeShEdcshONUEEcL7Dq9PJG5OTYVkw4lXrE6IvEx2
 BvRW0DtDqidxFhD2zGuZagHReqf8pwaAPJmkiWLs0JTKyjcYhKjxsLK2G1vZeG8SIGJ1dEYlI
 uCDukFrmvVsJiwngEFYOaKdSte9sTXr6iz4tnrBfGbQNcxUtTwyh5j9d/RCsTxgi9wNqGTQ2b
 a4B9PJQ5kcZgXCTk3cUTUOArFmXqHhrJ645XyNNTBaU6qUqqP5Stf9blk76ZGRIj1BCYQH+zm
 O0TSzW6HK3L3lXug5iecOTvBLJsVcK8sB/Xa6i6WmQNlLSTSbuY0KaMcyL/Z7G3h5gRdxLFUf
 domXQ/YoPrnWW/6Wzbnjv78UYW6tSRNJ6rqYxd/IHtWfUKOeo40TSUgwkQcOdIjuHq/crGR7K
 PXoNBrsmlmA2tQVkWXm804g8qUuIWtSAc4px0WfnFYGyhZNbCAYeGUdb4MDHl/WM0fqVv69IV
 Hmgncu1K/PP1kok4WqZ3l/LBRzfFOHCQQRHef7GQ6r3N8q9v/1Z62sAwDsVG7ECj56JgA0jaM
 /nIUg1lArUeXU4kuViZ/k/p3NJ52GgZ7VjKCG5ntGgAhg1OWBVpv9FNg2uwRYdkE3KX0Pp+wq
 ruPNHPAkO9ICsFB6ZXz8Yp1akwP//hNvUOWJ83FuXVEemWXbv7U3i694DPZDYZNY33i8wuww8
 rteKRVJKYUy+AArdmq7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/18 =E4=B8=8A=E5=8D=8810:22, Sidong Yang wrote:
> On Wed, Mar 17, 2021 at 07:36:47PM +0100, David Sterba wrote:
>> On Tue, Mar 16, 2021 at 01:27:46PM +0000, Sidong Yang wrote:
>>> When user assign qgroup with qgroup id that is too big to exceeds
>>> range and invade level value, and it works without any error. but
>>> this action would be make undefined error. this code make sure that
>>> qgroup id doesn't exceed range(0 ~ 2^48-1).
>>
>> Should the level be also validate? The function parse_qgroupid does not
>> do full validation, so eg 0//0 would be parsed as a path and not as a
>> typo, level larger than 64K will be silently clamped.
>
> I agree. 0//0 would be parsed as path but it failed in
> btrfs_util_is_subvolume() and goes to err. I understand that upper 16
> bits of qgroupid is for level. so, The valid llevel range is [0~2^16-1].
> But I can't get it that level larger than 64K will be clampled.
>
> one more question about that, I see that the ioctl calls just store the
> qgroupid without any opeartion with level. is the level meaningless in
> kernel?
>
No, kernel uses the qgroup level, but it's deep in qgroup code.

In fact, kernel treats qgroupid just as an u64, and sometimes checks the
qgroup level for relationship, but under most cases, it's just a u64,
level/id doesn't really matter that much.

Thanks,
Qu
