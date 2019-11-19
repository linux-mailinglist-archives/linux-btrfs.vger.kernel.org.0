Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E509710257B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKSNf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 08:35:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:47013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSNf0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 08:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574170348;
        bh=dW4BURUPlR6H/mrsm2CFNc7ln9PyDzlXJKCXYdh+Zpc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gobQMKRfuh5CroSxO8isGPNwdql7javBcNzD/N7ycVTQrsJuW8GRA6iL5k3LGa+cd
         rk8r/uwiJjI4F238hwjszysejdrDBJdc9qrNtmFcgOhHkPBdxBnzCDUul3y7cJOMFD
         ekYdX7gvYjX7+n9IyRQKW4V8nJawwS34Lb/9PEv0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Ed-1hrpcV1i9N-013MX0; Tue, 19
 Nov 2019 14:32:27 +0100
Subject: Re: [PATCH] btrfs: Fix error messages in qgroup_rescan_init
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191118121644.15289-1-nborisov@suse.com>
 <20191119124554.GS3001@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <82694f62-6470-a575-b81f-3a0684077834@gmx.com>
Date:   Tue, 19 Nov 2019 21:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119124554.GS3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eI+0p5n1gLbRr/heMnTf0VerKsLklo2ww45/yXVCrlJnQue+Kcx
 2inkxrGd3vhKBxs1uaWkDlKDvnZekMCjprm/u5YQueS/WZCOC1K+3BSPQnZKdvt+m6pVCTt
 T1fjBSvj8XK2yVTB74S54T5LPmu2y/UHTde03YZe7HOBdkHLcb87F3Wd9KCO41jglkaRoUC
 YGlZlLXAlE1mPJYpaRRcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:riji+s87w10=:CZpGrHZwewsUXzXxWvcOHb
 FuXoi5fNVuFsG8qOS8rUMQts//akS9ZAfV1TP4ksCiWFAdSyY+IxO/CZDUaPL95oHPM8V5zOB
 xsd0sQsmg4M4sC0xNzh8+qVlm6Kdhu/t2lHTeVjZB5b8JOB98ePigh2yzWlcsy+kQ5T8ZXTCH
 rPVnwgw8ODWtUoWsw9RpOODBphXFgxpCM25C8Aj2qAIg0lhBuIRvLUDtDoxko0ESf/iBJlTZq
 U918o3zyAxfI/Auc21pdbIPSTAnZ3U9hMWTWa7vnfvU3oTMRHJGRmgq3ZcdPNBE1NS7DSOttJ
 vlm6tpwJm+kUGnK/xESaBJqpkPIleiyDH+GCFx7WbSu+JY+0Poy+J9D/26/e+wOCOrI+VxEqT
 rdR5JOknu/kyvzUdKBjiC3TG7o2EJDkcJoKTMpCGuKU9OTj0bpn8nW2LcUwYFV1yDW+Imnqmq
 nG4LicKKEes6UkK3iX16gU8WJTG5iVm93PKz1+MVZb/AqOH5dTSkvOAxYEcXSgmqn2B3G8XLE
 9LguBcr9JfdSviRwJqxvrNqIaNveynFKhaFKYx3ewG3unCM+NVzBrRF//rJQOdkDFBy3aNuuA
 dB/ZE18c1eiPKi2idIMpHdA7d9uBvgPx8muTqg878r2tGveVFKLg0NqC9d8C4Tq7FQuvPZvNl
 hGfcgY5cfDuWFPLJ9AyIyd5B+CMJ39Q/T8oRFiqOXPpu7v2YVdmuM3Uzsbf6mhGJHTO3HIdmd
 FaKIKXJ5vi2owytwag88KfC7ImnYJ0MgNnKHcA2dwHq2o7dlqnH068GexCCLM2AOyxJvjyc43
 3VaoqP+UAj07xmfh7SSRtPtWPn5PpxMNZoDvTIsVs+CP7BNUrKho/la7OCu7exhKeAaxLIleI
 Z/TmrfAvB08zpNsUBhXNx3vqVwJETOQb8OhDyDUFOor6PntCPjtNlxurxyxsEeWYpjQeMXbgU
 9jRCBQPm1gMBVtNkEEUNGypBiN6Pt7AF7vAfm0GUjS/LDYQ+TDYPWtjzi+jlCKhRwgWXkTiGS
 JjxIO3DRWZOT6vO3Bke93VEKcQ65wIUFr7RfoBqF+qs4DOqYvNM3NA3eUMWWJQpKZy8sO4P3l
 zGb64RQsEDxzIsAi0wiyUozEMd2GlJFXLdUYv4dK/LFWo0gqJri85pm/ajM9Ldwn03ag1k4AW
 RwqsPBdAhBJ4IWrKxZ+QZiDOzGTckG3JQQU0FVQxsPqJuMjzSpqAWF/ReNyZw3MH4XZorfaYq
 oeThGL15Ecfh3bTp1RjUy3AlSJgA70sL8DcDIce6cq8oBFkRUH15o20M7PUU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/19 =E4=B8=8B=E5=8D=888:45, David Sterba wrote:
> On Mon, Nov 18, 2019 at 02:16:44PM +0200, Nikolay Borisov wrote:
>> The branch of qgroup_rescan_init which is executed from the mount
>> path prints wrong errors messages. The textual print out in case
>> BTRFS_QGROUP_STATUS_FLAG_RESCAN/BTRFS_QGROUP_STATUS_FLAG_ON are not
>> set are transposed. Fix it by exchanging their place.
>
> While that's fixing the swapped messages, I'm considering dropping some
> of the messages completely. Eg. the warning 'rescan in progress' seems
> useless because why I as a user should be notified about that? If I run
> rescan twice and it's still in progress, there's no problem. And with
> similar usability reasoning, look at the messages and drop them
> eventually.
>
> The specific messages were added by Qu in 9593bf49675ef, to improve the
> message that printed function name and error code. That was an
> improvement but now I'm questioning the utility of the messages.
>

Yep, that 'rescan in progress' message looks useless in that use case.

But normal user doesn't really check dmesg that frequently, and as long
as btrfs-progs doesn't report error directly to user, it should be more
or less OK for the user.

To me, such message acts like a hidden verbose message.
It doesn't provide much info, until we hit some real problem.


So I'm OK just removing that 'rescan in progress' message, but please at
least considering keep other messages so that they could provide some
clue in the future.

Thanks,
Qu
