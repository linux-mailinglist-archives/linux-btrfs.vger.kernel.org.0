Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A55098E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385584AbiDUHLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355444AbiDUHLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 03:11:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29B167CE
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650524911;
        bh=YgnaftzM7e0MJt2tGTY7z5hFYXeyX6nY/xZVb/o5BZ0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c8e/Z4moX4g7D6Ek3BU6TW5xySo9azSOYL+bfYQY4lBjqABM62kS1Ksham9rNFUDn
         K40Hd0ZBf15jShVtLDkbibwS5NpH0gHqNq4aXASbXz6fICwtHt+1FQ1u+L70yw7Ahv
         diFUcMhvmpgy/dwkvFzkE5N+LZ+V/nJgVBnbcA3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5VDE-1nxe5Y0xXG-016weo; Thu, 21
 Apr 2022 09:08:31 +0200
Message-ID: <0afc33f9-d4ca-33ac-cb4d-88d5aff92bf6@gmx.com>
Date:   Thu, 21 Apr 2022 15:08:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
 <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
 <20220420201158.GJ1513@twin.jikos.cz>
 <dd842aee-c0be-9c10-f613-1a24d999c513@gmx.com>
 <YmDrjFZxqZnPt52Y@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YmDrjFZxqZnPt52Y@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWE7Cza0R0TMU2GaLk+/4vWEo0p1FjytZm8W77ybQDUkuCVbZJ1
 y3671TLuDS6nHSHBVMYBoz5GSSTc0Xby2C6YTilD+Ysbk7Ov24cfHwcGT4Jor9YtQlsK9L9
 EQDDj0FIkGo0h+vpbNH9ZC7RQ0YjausO70umwd8vdg/bc76MWjMIxVo6vP3j19sur5PrjnE
 w3a947CfMLz1WAT8un/oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDi2Ghjl3Lc=:RFsUnUZXXBT+FNwA/cFev2
 ZTT/ihSqE/S1IQOMCFTo3az1vKyH+EeBlPPgUS0z1lAUKC1RjYBCFHaf2FMlyoG8C/fbH8YQY
 8GUVWW2ryWQ6SRnNe00IoP3LVJSIx4PEAm7f9Qw8fp3g6HAiEfzauiZxcJkigcXtEneZMzMVa
 4tj34MAwB3DYOLouWCXb9ytzMQmpVOLKHXsMRW465ir8hT8FQ6ujXJIdXV11i7rnTkDnRbn9v
 rIdyDBNJ3lc3zzXU5DwKLQevxRURQ25c/F3Np/hpQym3HWlM99UdP1riNbyKxK9JyGHjZMTuw
 cKcU+/luO2W04T1D6zhC09VoBNOCIWrZ6hCLU8lChHNqQQ49emLNibvL4R8/bfQjGhKcWv4cL
 nJS94JPWcGewDkgGSr5ywMErrrZ6NPKFF317Op91uBFrht/jcsoZdk2dx8uis9e23s0DAT1tI
 MkMc0EEi9upj2Ckw3XQxf1Ug0nRbM4vAtgejeWj0ZyrwTGZXuKgBB3oRggpbpMazT6AI4OoOZ
 B6Mye0cdTa9Obzq0dHDB3SRlzYDObhdB51ZZ8mV8djR3X6TmVgvfh6KZAzbcNd2Cu9nG1/P6q
 8KcskFKZy47laaNxHxbF0Ane9acDJiA/lWKSwSR1qH89WSXJaO6tPW+DZTCqgTuIjxM1E2AXS
 Etg0gKEkGRPVlao5iBBixcNuyiAqPw/ci9ZJBXoiteVD3F2e36dSA6g7OM5D7FoeqVxGZkCVH
 6sCmY5ObipBR3z5B7CY6Jb+iNfcz9T+2eQWBBbYOp1/sGQhOeW1QTTFRl9V5AoPbNjZqUzCJj
 pHDb1FRtXKvzmpUiLHKvrp8p9JNn/ZUJkvTpz00TUmH51CU5zNN3trn06BhADk5lqCW/ZpAr0
 6hTVh3SCsj8oBvlgo/aR5Eh9p0D7UlKUWXSx8vx4ZcJBSy9t45IUMjaxTowSHA5JIwLqhnhh2
 foM8X/7qtp2FJQlf/3BUROFA+BAZVKNyA+NAnVN2CHv26Q2qw+pp2VToZmZF6DOxcE7B+773l
 xbZ01HeKbEQA7Z0O/5by+Hy1uo6G3Op0kyLIJ/fFFaDDOvraM37tQAqX/Vg1HC7btwwZeE47O
 Djm6WzcNtNCoCw=
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/21 13:28, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 07:04:25AM +0800, Qu Wenruo wrote:
>> I'll refresh the patchset, still keep the core idea of splitting bio at
>> btrfs_map_bio() time, but also take some ideas from Christoph to furthe=
r
>> improve the patchset.
>
> I'll have about two more batches of patches that don't touch this at
> all.  I have a bunch of ideas how to deal with the splitting after
> that and will contact you about the ideas.

I'm not in a hurry, especially considering there is really no direct
user of the delayed bio split feature.
(It will make a lot of things easier, but no determining effect yet).

So looking forward for the new ideas.

Although personally speaking, the zoned related code is a bigger concern
to me.

If we can also do the zone split at that delayed timing, that' would be
awesome.

Thanks,
Qu
