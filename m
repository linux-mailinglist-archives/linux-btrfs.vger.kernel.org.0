Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFB576804
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGOUOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGOUOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 16:14:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202F745981
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 13:14:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l9-20020a056830268900b006054381dd35so4309039otu.4
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFPxVNys5mN0QNKD0/uGugU2wPX4Nn2cNUdeiIqosNo=;
        b=T9ILOIEL+t7aHORdAuGjTH8bPJojpA/bYXv0YWkoGqir2wd87Pm3IeEzmqkMAZkLVP
         LeLptir+3ry0jbZqkYxMM87HFZfE4PDJ4hCGaarYait4b4Ibvc7cjrvOwaFlQpqMJuy1
         wTIF+EG+GvXjqHTlRXzHw7IXHk96vKWZXJHwt0FClO33o2fbZX11/QOprDbf4z18rqcK
         HDTZOcJ249TS8aK7ECuxk7RAFbBKS/0/eo8yvQ+fUwCDE5EW8uotQRrurQJi0O1JK6Yq
         UIvt8TwECiKY/0/ximIWWruuH51EHyjI64gUl6GOamyOqEknrEB6Z32+j+lkCAMe2MC4
         QjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFPxVNys5mN0QNKD0/uGugU2wPX4Nn2cNUdeiIqosNo=;
        b=HnGqiHCXCRoddEm48DS3eWAD3DJ2BWKroIaRIxbE5NAhjAK2qy+wfTTqzmk7FgbjdX
         tjCwnRb9II9IRHqBkJ5gktD8XQVAgT6Oa0OayDg3xmnawrMd+jtXufJfOEyVI8mLXzmv
         M3GpCJGzhpzq8Znpy4hnJ1IHWtP9kyuclE8OXzMI5NXnorJJeth8uBNRXEQPUfXw938Q
         d7bP069Z2Mrwo901e+ERKsQE55X8v77mXmkt8vDX9oQRSehmGJbeSCHJE9N4aihM6Jdt
         TRYG794Q7fG1XE7FJekheNeBlLI2lzDKE3sL1epf5ZmWWHBLLKrWVA3XCTv9gXrgi+m4
         r+tg==
X-Gm-Message-State: AJIora9UZfhR9ulVPod6ihYmBAMmS2kKohmxDrFtGb+S4JXX5tIGlpZs
        9MH18CMyrW34OcXAMFWMYovwEH/wTz14W+2cxaqKkg==
X-Google-Smtp-Source: AGRyM1uRXNODOyQxwPep0uaCS2ziQ6zci8EYxR73WFHhCnub2h7kfYL3dxSpXMF4C0AT9MPKxuOYSxjuXJkbncpCQN8=
X-Received: by 2002:a05:6830:2645:b0:61c:5aad:632 with SMTP id
 f5-20020a056830264500b0061c5aad0632mr6397542otu.169.1657916072238; Fri, 15
 Jul 2022 13:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com> <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com> <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com> <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com> <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com> <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
In-Reply-To: <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 15 Jul 2022 16:14:15 -0400
Message-ID: <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 14/07/2022 09.46, Johannes Thumshirn wrote:
> > On 14.07.22 09:32, Qu Wenruo wrote:
> >>[...]
> >
> > Again if you're doing sub-stripe size writes, you're asking stupid things and
> > then there's no reason to not give the user stupid answers.
> >
>
> Qu is right, if we consider only full stripe write the "raid hole" problem
> disappear, because if a "full stripe" is not fully written it is not
> referenced either.
>
>
> Personally I think that the ZFS variable stripe size, may be interesting
> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
> we can store different BG with different number of disks. Let me to make an
> example: if we have 10 disks, we could allocate:
> 1 BG RAID1
> 1 BG RAID5, spread over 4 disks only
> 1 BG RAID5, spread over 8 disks only
> 1 BG RAID5, spread over 10 disks
>
> So if we have short writes, we could put the extents in the RAID1 BG; for longer
> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by length
> of the data.
>
> Yes this would require a sort of garbage collector to move the data to the biggest
> raid5 BG, but this would avoid (or reduce) the fragmentation which affect the
> variable stripe size.
>
> Doing so we don't need any disk format change and it would be backward compatible.

My 2 cents...

Regarding the current raid56 support, in order of preference:

a. Fix the current bugs, without changing format. Zygo has an extensive list.
b. Mostly fix the write hole, also without changing the format, by
only doing COW with full stripe writes. Yes you could somehow get
corrupt parity still and not know it until degraded operation produces
a bad reconstruction of data - but checksum will still catch that.
This kind of "unreplicated corruption" is not quite the same thing as
the write hole, because it isn't pernicious like the write hole.
c. A new de-clustered parity raid56 implementation that is not
backwards compatible.

Ergo, I think it's best to not break the format twice. Even if a new
raid implementation is years off.

Metadata centric workloads suck on parity raid anyway. If Btrfs always
does full stripe COW won't matter even if the performance is worse
because no one should use parity raid for this workload anyway.


--
Chris Murphy
