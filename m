Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D8411340
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhITLDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:03:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:34939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhITLDD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632135693;
        bh=UsxGnQc8Sl15wdAX88bHLQLk7dUavFALD89u7s4OGHY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TBsKWPumnCRSBwL4+uP1WalY+DiUy5Ziv1wQD3PrrfDL/+FB2ytiXUET9JxYxfN+t
         K/k1c9qw/a/W3Dg6qxFSSCQBqP2HyQ8Mam1aGyGh8o57BB0AlZqiF+JPMhJF0QhqWS
         jSEzJxTztS3nOWNEbt6vB6oHWSjFqxOcu6+i+cJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNY2-1n1brw3ExM-00ZMop; Mon, 20
 Sep 2021 13:01:33 +0200
Message-ID: <c7400d63-b6a7-dca8-e921-5f34ce2b8a06@gmx.com>
Date:   Mon, 20 Sep 2021 19:01:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/2] btrfs-progs: only allow certain commands to ignore
 transid errors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210908020543.54087-1-wqu@suse.com>
 <20210920104343.GD9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20210920104343.GD9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0LLSDcUe9bEJzXYfjNYTb0bgKKnoZOXzdsCk6H7FPtOAklniU6R
 ogF9aP8rM2i4sZTf/CXluu4CgcksZslyc2fnq+uY8j/jmsJG+W/wA+QCnmJgY4chwmT3C0Q
 7aEUVf9ZqBfEsCS4wRnFMbzLZ3/NsoXQzgR+Uzpdl0yhSUfRdFYR/ItvMoS6iWzodS18thb
 Bf7tQBVczjQteVCBQjeGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DJAfjGgtwaI=:zmkTpMESVolXH/UumJ3Y+L
 +orZiBPxRfJnlIJO7PZsUHy1t78GNDHUl9IK/Jo8p7HEWkrfNzuu9EZlInU2nsDFbIv9mEqjW
 zHFrbt3c/o8/9iJo67q9j2OZ0DLdXNz6e1fbrJVmJWi6BB9woYuqkCUN/WvQaQT7uUbheVaKc
 Uz2OxrIGi7vwzmVi38cX6S4KESjV0Wvok+dDni5/FNm+Z+Us+iK3OXLg3NhC0oAy42AaIC7Fc
 TCIt3eOx9e5GmDNHa4gxDoWprnvyr7hHgcaMJ8nOWkfUMBzP8Cmt4VqPgeeiqL9pfg0Svx8fq
 QZkKEOmOLRze6kqNQncRueaUrKlJ4NElaMUh0qFoDYIT9C4OY7awu+7vgYfh5RJz4D/LLTGo6
 mkbWF3t40P3UBMgCrwV1Mvq09lB6DMnSejYR3RZOxX8AqZWGSDc2n2ckstHPXiDX+L7Jq8OC6
 OwIYbUb7ObP1X96oU7iVILdOsxT4OBXVYjJfhZMFl8F2UCI0MkXyenEEeSMKS7k3az+8qctaC
 KJxNhbelq7AiAo5BxlNaGWA9mckRjS/1irKwZ8WFUTun6n8/iav6q0RoSPtkVejCGdfsCFIEy
 m1teY9P7Tt1CAKmoZ/soCaAONxRp1KLsPfUgImCTavLCuBWPRU0h3834KB4kUP7Lr+D+1JgSD
 RqCSWGXGYmEQ7+0geRJxV74EK0u6oE/p/ZSXMg7mSh5fR5N7E7keH/vc0a52JGFwEBPWAXYCE
 4QK5xVDEz64iQhp2YZrB6DkZwngUvOt4/U0D5mboctyNmh2sUHSXmFSbmSNAW92GL3DnMcdHa
 cmPOdhpAQ8zMXfcljK8UdGImuwLo1KAGhokEMiAPeoosbub/+jF1Zq/O7P7UtEQmcUnWEDVmL
 UsRQCElKmyAc8ebydi3VXU9g2pPzmX6tVcjqYgcLONGnMdi7J3YuetgrmKX3nmzdx/6Z3i7zr
 UTgjd1/9w0HJ6kC2j19zfAZ8ZiJVo/8vqvGuHTuxQiDDSa0vtq8KrDg8igEFwhi3Rqo1EN5/Q
 +xZN5tJYUOBF1jAwICRws/bHiTk5ODbLdaYNkoljBt9pe143aFUoW3bff4f1wy256lGVbVvQ6
 gKFI+yM518ggU8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 18:43, David Sterba wrote:
> On Wed, Sep 08, 2021 at 10:05:41AM +0800, Qu Wenruo wrote:
>> There is a bug in reddit (well, really the last place I expect to see
>> bug reports)
>
> Why? People discuss things where they're used to, reddit is one of them
> and from what I've seen there are good questions or usage recommendation=
s.
> Some of that goes to documentation or helps to tune usability.

Well, I'm more used to see memes/trolls there, maybe it's per-subreddit.

Anyway next time I would drop the prejudice.

Thanks,
Qu
>
>> that btrfstune -u fails due to transid error, but it also
>> leaves CHANGING_FSID flag to the super block, prevent btrfs-check to
>> properly check the fs.
>>
>> The problem is, all commands in btrfs-progs can ignore transid error,
>> but there are only very limited usage of such ability.
>>
>> Btrfstune definitely should not utilize this feature.
>>
>> This patchset will introduce a new open ctree flag to explicitly
>> indicate we want to ignore transid errors.
>>
>> Currently only there are only 3 tools using this feature:
>>
>> - btrfs-check
>>    It may fix transid error (at least for the specific test case)
>>
>> - btrfs-restore
>>    It wants to ignore all errors.
>>
>> - btrfs-image
>>    To make fsck/002 happy.
>>
>> Also add a test case for btrfstune, to make sure btrfstune can rejects
>> the fs when an obvious transid mismatch is detected during open_ctree()=
.
>>
>> Qu Wenruo (2):
>>    btrfs-progs: introduce OPEN_CTREE_ALLOW_TRANSID_MISMATCH flag
>>    btrfs-progs: misc-tests: add new test case to make sure btrfstune
>>      rejects corrupted fs
>
> Added to devel, thanks.
>
