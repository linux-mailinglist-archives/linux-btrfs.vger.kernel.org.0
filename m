Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F784E5BB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiCWXRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:17:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135E90CC0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648077343;
        bh=TbZw4qfpuVQ4t9MdU4iyCyppvgGgwGXjN7sboVwqbyA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=G86I1OnDbeIIH2EXPb53+m3G3hpROVBYZqoHbsuDhELrR1//ck/1+4Ux67a3ywLMi
         hV8/NLwm3kv4soyiZ+0K5iVGh0G37CVznJOzkW/tOswnES9pd4ng1C5BD7s26ruG4u
         xuuGZ5caXqB/XCTsy3EGcygeGI6jOsc2PIr+SJVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH5a-1o57VS0VP2-00ch3r; Thu, 24
 Mar 2022 00:15:42 +0100
Message-ID: <f52f4d7e-1d9e-9680-3aa5-ef954f0135b2@gmx.com>
Date:   Thu, 24 Mar 2022 07:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] btrfs-progs: check: add check and repair ability for
 super num devs mismatch
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <cover.1646009185.git.wqu@suse.com>
 <029df99dabfee5b8fc602bf284bb3ea364176418.1646009185.git.wqu@suse.com>
 <20220323174315.GC2237@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220323174315.GC2237@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGErZfeqqdXmyr1gL7sgAJeC1kjTU1plRNRKCRsdor22FiA6Rz5
 W5/VMDoxiZojCSWVd/atuSY9Y44MIpicJvgJkbKXDpnuVlDdL8uwLJGd87rZXq4DdPNFujG
 8HBPhntq+kD7oCcLoBMr6BLnBVvniLMO42FMghW6OLnmaoyCxj57hsMaE0npThhjRzH2yf3
 tDYJFldzRXS6I7vcNQc7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8f49quY5KsY=:fDu0r+qYYosqJ9XiE+9Woy
 cCr/DcLgtIbrVHO0ioN5V6EOyoTKetOsw3aGLC8o3eylqnWwxvpu5rYNQH/emhIWO0lxNSi5M
 MqR/jyAfBpvNilskQISTXIQjiDaNicU936kYK0d+BurMsLkafoRQCYCN11a6sVHjNYQatkJm1
 cvrEGBt/WMQPtyAsGhxipY3gnz2MjDOEpwOiNMcpJH60BbR2eW8VclZhudgSPmkn+cX3taMM2
 uMc6IG6JE69oGVL7AQL5KrjyseS8O4zH59dxkn8jbVNlUjB00D/nMBANFDG+gocYjQrRt3+Vv
 x5+vEWDBUTs1A/l4wFprMprQHJVqJCep/Em1I6LkHdKNWc6EMPbf6HlZlFoqeG+TDp2kzYizg
 RM2IA2482Z79X4JDBGblkfV2qvlsf+j1O11rmv7UBO706xpAv7OMFJcJfVRL1cdjyokih2awC
 Qwz+TgkoWzi3wmV1JYL2tiR9ytidujAmaN7n/p/xx1IFWTYb0kRFv1U2a3AKjZ96gb3gtRmB2
 r4OiGCahWYqypsF3oyd2JsTm/CeEPWNvc7W8Lx+CXIo7rPs8L12TLr2tJpPH4lIxj4Yrsea/t
 /qiqJDmJvXCXNp8/PkOIXOztpRyKQDKxJDqb7mkV7h0QHmuno2cLi2dtGTW9Pt1xBrtpImivv
 fK9xkXq7g0Lc8oRDVpsm3rbJilHk8GH2u5sIBxvd/Icd6pdQS6jeW87m6OucYtjGDXSXvKpCp
 +9uakAgVyOb5tjHuzqfCKEyTGkrY4AjlS/b5J0pst7sJMJrbPBZRU2aL+UdSFBXxfNErgF06d
 ziKV7KazmLt0TO5bQ+Am8QGyl9ZWjKYo7zE6g5a9uLu2a4AiUHSxf2sAELjYIuDuXGT1yM2rL
 DoTvH8uvoj+AfqZgHJz5VZFdco7l2Op4DGV/1OK7OPfyaGWFz5zfAhDPvISwqO8lEhn4KYi9T
 oQ3BAFjR+OsMdrC25Xg465Wy2ItX+6k2xqj6/UHIXagMt6jeAsw3mTOCgu6eUcE1vs99Eeprs
 9z6/11tVyRfGn5tcYoCbd+1JNNdhHCQ/1dL76GfjRSADQDrNh6SlW06J0fNsz4I/ExHNYYhms
 xo2YIYYjJMugXk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/24 01:43, David Sterba wrote:
> On Mon, Feb 28, 2022 at 08:50:07AM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report of kernel rejecting fs which has a mismatch in
>> super num devices and num devices found in chunk tree.
>>
>> But btrfs-check reports no problem about the fs.
>>
>> [CAUSE]
>> We just didn't verify super num devices against the result found in
>> chunk tree.
>>
>> [FIX]
>> Add such check and repair ability for btrfs-check.
>>
>> The ability is mode independent.
>>
>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_=
cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> With this patch applied there's a new test failure:
>
> =3D=3D=3D START TEST .../tests/fsck-tests/014-no-extent-info
> testing image no_extent.raw.restored
> =3D=3D=3D=3D=3D=3D RUN MUSTFAIL .../btrfs check ./no_extent.raw.restored
> Opening filesystem to check...
> Checking filesystem on ./no_extent.raw.restored
> UUID: aeee7297-37a4-4547-a8a9-7b870d58d31f
> cache and super generation don't match, space cache will be invalidated
> found 180224 bytes used, no error found
> total csum bytes: 0
> total tree bytes: 180224
> total fs tree bytes: 81920
> total extent tree bytes: 16384
> btree space waste bytes: 138540
> file data blocks allocated: 0
>   referenced 0
> succeeded (unexpected!): .../btrfs check ./no_extent.raw.restored
> unexpected success: btrfs check should have detected corruption


Weird, the problem is, for the restored image, if I run ./btrfs check
manually it can detects the problem, but still go "no error found" path.

So it must be my patch overriding the return value.

Will fix it soon.

Thanks,
Qu
