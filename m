Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5817F40F6AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbhIQLZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:25:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:43969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhIQLZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631877862;
        bh=eIzoQYDW+5EvgXNAp+dwEZBb5nq+3m3Sgt082nCHZEo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aQ4moRRrvNbchu7Tp+y0G70myXTMjuDTGPKQ/BPpo1elFeW5EeuyxIrQ+2cpRK39R
         k7tytX7PIUynANFczycXgqk80VWN2E2WcTz84D/ppe/twF4jjjCsi+Gs3OiY+enX3Y
         G/Vh44ee6vQipcD05VPFWOoc17ST1ynfyfKZjjlQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XU1-1mwHa82f1V-014SrV; Fri, 17
 Sep 2021 13:24:22 +0200
Message-ID: <c0d3f033-5b53-4026-d38d-e7e9284c1f80@gmx.com>
Date:   Fri, 17 Sep 2021 19:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/3] btrfs: rename btrfs_bio to btrfs_io_context
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-2-wqu@suse.com> <20210917111923.GN9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20210917111923.GN9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5KHcKwOS/phjWM/Xq35ryIRf9YYWxm0Efxe1lzZDMaKZku5e80z
 OuiCWkoIaQM+RhEfI72OgXqmrOpP1CinFSZ5rYRUAIIl94TPHBcuSntttpngwXlbf0J83ny
 SW/4k47sxnfvZJ9tFVnnCoaFWpOd8yOgGNlhp+WAt2F5DcAgNjv1r7v83Hae8SoIyeKPQeu
 bNFgmnnE8Vob851Lqnc+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:csJp/Qzss8A=:aSStyXBtqpkqV8PdoeMqYo
 LLTswmimM4IKocXv5/M5Yp1uKAtcPMhctjgoBOXFaVLxHlKUtPbFcFxlIfTQ1AIGbqVzxgLaC
 uyLGlfQrYVRRaz18gk/eLJqM2RTfnBMN6qPOlQ9dgWKAKe3uZJftCak2OxBQKyw5P5z0Bundk
 YnAcbiIp7Amemj1EQxbHFO5OxdOapvZwvzfED78sdM/gEzfybr46+NO4x1WAv65XOTDZ54Z7A
 LpAxkyYev1rU/FKNa/xU1uwe7WkI+Z89hjJFivKiRDCystM+52Ps4WsVTibtUKxnlSujbVx+u
 HZRFzgrBDg0+6xkKb0XJq7YrTDHn/ZAfQqvFi2mWf5/TkLHfQSxF86gySTZ4WjWoglj/sWFxV
 AC4RouYKIetwTkqfd9YpRt1Ch03HQfrZOerri8nSLzE2JEQPcJ7K5HlIrneklviaBxGYPRAnk
 BlDEdS6CnCTYkyFEM4M0+B/53Drh33sPXqEkWTB88UL4CucDlAL44mslu4Y7aHrIErQ595eOg
 6vYsF9/DEt4AR7zJTTysYyDEyGx0M5rjuF3+TA6oqcIlApDSuADusQZOofUG7OoNHjmhl0pL2
 wH5katYgGQFKAVk8/v+k5BCZJ8XdaAO6yrEGWs1PyACyYCnxx9scZP2a6Wj+3EghmmFkChk5w
 CCPiz1Yg3u/yZ84ffc5JoTEXQVCjf4fxNWxaOWIIWS0y1piDJ6/ULIHhjbFIxfc34nuCE/RNK
 QcMRCK86Z4dpxqQED7pARpO7LrrIWH/8G97OdCbpKYbyuTdW+uwV7QX0hWqtWEpfYPHtvxGR1
 aV+GzxZyQLKPkTJP5NkQ/gOqVvVOkAj+jSUR3rfGtJpu9EkM/Es7NEMDnW8Az+xn+SF2bT9aO
 oUyHcgEVAKsi/XzkN2wZC95y+P7HxbG5Z97k2WDg7PYtCe8zFcBhNVwcCqqS0uR1ZIFD/13ii
 9WicXmy5tDb+1VrP0H0/av9AcO96xBUajl4dbpidRiQJHkHQnlK4ppbSQpcUwUAHgzAe3HliA
 sMURLn5bs2oXP9iNuTN6LRM75EBBSE5SqQKJxpyVykRoNYmGDmmXa9rSWNXg/OctmjHrlfjjW
 cHj5bOx3YJ5EBo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/17 19:19, David Sterba wrote:
> On Wed, Sep 15, 2021 at 03:17:16PM +0800, Qu Wenruo wrote:
>> The structure btrfs_bio is used by two different sites:
>>
>> - bio->bi_private for mirror based profiles
>>    For those profiles (SINGLE/DUP/RAID1*/RAID10), this structures recor=
ds
>
> Why is SINGLE here?
>
For single we use the same routine as RAID1/DUP/etc, it's
submit_stripe_bio() doing the remapping.

Thus there is really only two types, non-RAID56 and RAID56.

Thanks,
Qu
