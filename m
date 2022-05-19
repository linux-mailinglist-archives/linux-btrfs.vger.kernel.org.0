Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDB52D1C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiESLsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiESLsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:48:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA77B41FB
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652960917;
        bh=/Q22iYrncIsznpfMX3tEV3deZYopEZJfVhJCBZKWS04=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KPmxGtQbGmovU0vc3KPL4sZhIiUZKsXYp+2PoEXSsUL49H6UvhMbKaqG1Zppz0cyE
         1vOc/mbUK2J2ys4OgXxTAqO4WFIzcpcGg5adVz9sIlg/+VkmZRhcqGxnFWgsxyEu5V
         srZtXd40N5+1apm05Gx/3s6TZjTNhRjGg7jc13Ec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1o7IuD45gP-00FgWh; Thu, 19
 May 2022 13:48:37 +0200
Message-ID: <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
Date:   Thu, 19 May 2022 19:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YDjeyIn874gqFG2/dXlbEud9nBVtVvI9A69924o8IW/O77mv2qm
 ws17g3Q8+DYNHcr5+TJHSXUUwpvY7R6u57PUFNS8XRMk/e4ADaOfmVaMWReiaV15hIEx2OX
 wEPwvMov5mxsImRXvtzAF0jG+lpXPYScXwB2+6OiTpfT2s3Src2MOt7RMXNwTQpVWIw4XKs
 DD0CVboYIPXU3GvEvEIkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMqdwiiHRwU=:5+0BC1uGD9OedGqgAlIqrR
 LVAH7XWKJRejlXu1wtxNw8sW3aP2XhjWHcQOmddOiRZ2tqjxhgGvViM1AE7EdqYlLNGgYcD3g
 JFIxyjTJls7qATFlen20HpqHznZAj/I3a7na5HSlUJ0kXnuYn0Qvc3rF82MBxEkPosyicII5x
 fNMKwsRkUE9k8VrfXxu+Ja0PE1NzxsAfyiSau/+2i/ZshncGHbmfXqW6OwXNikQXLoZFZRtqZ
 YpFlK7a51J8bbkye1ayFqnyMQ3xbX87aggMng4C/0lQhOT5JhjIHWRhLdxwKYPiiCuaarkX6t
 Cj772jE4f1E91mQXL+DK66UKP1b4dQrLuDk/2mM1wTL6VWGRgFjKg20hi+pPucdP3xzN+By6+
 N/EqiQom8p/uiG3FmrZGJ24OEU2p8+FugEpa26XLTL1Dc7z8a+0UVTkEYOWKcx+rxndSBiuQC
 aLFcLjvWiL5p4X1eGL866TyVj6ywyo00vu3KTCteZ/AF4XLFYHFk0keqd9c/v/sH+9M3+bE2T
 3IolGp+0ZWdJKQmmDMnJXc0/l1k6myYWaPA0EbOPKBciT5JY9F2LAjdp99jRAPTaYdQBIz7gL
 yOREBFhVapYjBtbnnjRDq/tigGpGb7SGQieFwMFsei2CtHfbLZiv4lrhtBexm4I5P1tNX9eFB
 IG5bol8olVkEJcp4sJ0SuoO5sNKPtqbIHpz4tv9KojeEAep6dIBrCdWEn7w96ZWP4SjFu+XDt
 QVC1q5m192uJQKbeqf2rw2ENefh9HrLa9cqzFczsM8XfF0SkcUSWSTOC1oY3Qrm4IqXur6IWo
 PvGe99uK1dzRTssk9IS1xrMWJ4QE8QZ3zk+xlCwho2uEUJlS1kthQhrjLTJHIXjG2IqHXv/qh
 2/RVc7+1IhhLjV1NIcXPNM9iqXpwVayqPb2PBwKsCRtS97P4yRIMDR0PqwW9xJQvXtdKDGBJ0
 1U232qMk+PV3LeqUJXqQNWFFyRu7uDrpmVArp0Gqt1H2rq9QWt5yMFmOJFMn2gDeiBMJZgSus
 5dlBoz6NCusuWT4WbC04/WmTjLPUHsKiWnDxJxczHF2TeiJUgfs2da/QV5IoXBrvGlrjNjB9i
 Cy5Z9LnDX4Ffwj9gT3g/RU4sWpnes+Gkdh4GASKlar00fjZ6m/hIXBYnQ==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 19:44, Johannes Thumshirn wrote:
> On 19/05/2022 12:37, Qu Wenruo wrote:
>>> RAID1 on zoned only needs a stripe tree for data, not for meta-data/sy=
stem,
>>> so it will work and we can bootstrap from it.
>>>
>> That sounds good.
>>
>> And in that case, we don't need to put stripe tree into system chunks a=
t
>> all.
>>
>> So this method means, stripe tree is only useful for data.
>> Although it's less elegant, it's much saner.
>
> Yes and no. People still might want to use different metadata profiles t=
han
> RAID1.

For RAID1 variants like RAID1C3/4, I guess we don't need stripe tree eithe=
r?

What about DUP? If RAID1*/DUP/SINGLE all doesn't need stripe tree, I
believe that's already a pretty good profile set for most zoned device
users.

Personally speaking, it would be much simpler to avoid bothering the
stripe tree for metadata.

Thanks,
Qu

> I'd prefer to have system on RAID1 (forced) with stripe trees and
> data/meta-data can be whatever. Of cause only RAID5/6 or higher level en=
codings
> which might need a stripe-tree should be accpeted with a stripe tree.
