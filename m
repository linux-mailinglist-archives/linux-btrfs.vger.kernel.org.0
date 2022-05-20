Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C452E52B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiETGlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbiETGlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 02:41:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C5663C2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653028905; x=1684564905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ERGO0BicII1hfeSBY5CHGEqJyFEVzDz3Fun/2WvjKlQ=;
  b=JTyUFqsmE0YSVG2RBnV/I0Hr5RJP41nLIV2OLw26rEO526OcNVexUOqW
   76d90YBxQw0vqpfmMqphrwUg45v6LMeS/XDoESiUCRPpP0j9XKoPOsItj
   osZsrnmewdLZ2XjRuqhS88qsIwBTRNjoPXJMKb4iEdQo9r7Dp/oUW1SlI
   vnFMvHnefla2pF1Yo/R/Q4zt3ocPEqXGH1zqcm+g6u+499bHYqTcU6XwS
   sY+pf+y5BdiQ2R9KbZ1kf71J88Ns8Kewl2dZETDY5+xO7h8+CjrtnbYFQ
   KyWIWobOHH0vnpvtIXXCkxZwOyv5dv2bWBF0f+q4jzOg2Hxs6N1g0gXIn
   g==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="199688327"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 14:41:40 +0800
IronPort-SDR: j9VBgNkE5Xy/HLDzi2O+CHI4r1QN+IyL94WvgIv6EIIs5fBvmhbxYQUSJRWTgwisvQekOzMPgm
 vcUJ/EByD0PlSj6x4Ywn3FU7VWMlJfY9QcgSPG2unMx4Cj41XbJvWS79DOPTbRsdninkmP9IKo
 +ndqz/slzzsifGqrOayz9bxp3GNT4v3YlpWxQwtMMZDtuj1Xm5J7eKL/A188L0Sq46RD9cGejr
 NE0+tXVKSaeNI5u2emRgbiNJzatiiAfLE6lSs/Khr5cMtaaGXm4Kck+Tzq5UFXRaWJlkPggo6k
 mmeEfmNW21Rc5KykKhNvm/jW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 23:07:03 -0700
IronPort-SDR: QlWO9Es1w6nMEJTzNZl3+UpyMEAyCiXLGaVflVj7qEPOj6DJCPlW5WYgqsKwm5ITGBb9RK1YkH
 1NL4ja/547A7mjUeDupCWI4jzFygqcScqyW0x3QEZjgOCYdRdLRbFSYz/ESr8JjbVANWWcosgp
 BEym6F17cs/Mm0KTKvBOqVu+lDzjrUs7Dp8Lkr4XcSFnXR1XRc2rxWPq4IEH53LhmJXbbCt0sD
 39TBKedR2bk/cERpH+CCYK3xrJJ9qusJP0Nlyz9YorR0sE2jUjmSk9ueL5ADgtQ9rTYuQ3woSA
 MBs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 23:41:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4HFJ0bcjz1SVp7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 23:41:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653028899; x=1655620900; bh=ERGO0BicII1hfeSBY5CHGEqJyFEVzDz3Fun
        /2WvjKlQ=; b=WcZfmN40Q/nQ7cnBNDuPUoAgJ3ynE7bfBCKKkbIzlvfYBu41ur6
        0kL00xpfBgpyJVRy6Jl4DrfXpJT8y636ijvCj7PCnNt3gyaH2vLkae8y5Z91mg/U
        xbemCfwagpoA1c6UqhOwBhy+JV4rp7QS8cDhib8sItdjCh9LzRf5xZ0wFY5ovV2H
        eYRnf0DROLKYgcszUf8OXinleIaMRF4xKD0861/KwtoyaQYpnl02quLN14jqSFdZ
        m8opXNtKnguofY/Bq25QoRD1TXv8O8h1kJr1n+Wx9l2R37Ctlt8R4MTyzVkws3p4
        M0LiX4Eh5yQWcacWIwaHwdOK7jBZXOVlN8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CoiCCEEy7JmO for <linux-btrfs@vger.kernel.org>;
        Thu, 19 May 2022 23:41:39 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4HFC1ffTz1Rvlc;
        Thu, 19 May 2022 23:41:34 -0700 (PDT)
Message-ID: <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
Date:   Fri, 20 May 2022 15:41:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
 <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
 <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/20/22 15:27, Javier Gonz=C3=A1lez wrote:
> On 20.05.2022 08:07, Hannes Reinecke wrote:
>> On 5/19/22 20:47, Damien Le Moal wrote:
>>> On 5/19/22 16:34, Johannes Thumshirn wrote:
>>>> On 19/05/2022 05:19, Damien Le Moal wrote:
>>>>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>>>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrot=
e:
>>>>>>>>> I'm a little surprised about all this activity.
>>>>>>>>>
>>>>>>>>> I though the conclusion at LSF/MM was that for Linux itself the=
re
>>>>>>>>> is very little benefit in supporting this scheme.  It will mass=
ively
>>>>>>>>> fragment the supported based of devices and applications, while=
 only
>>>>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>>>>
>>>>>>>> FWIW,
>>>>>>>>
>>>>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>>>>> videos become available, folks can decide for themselves.
>>>>>>>
>>>>>>> There was no real discussion about zone size constraint on the zo=
ne
>>>>>>> storage BoF. Many discussions happened in the hallway track thoug=
h.
>>>>>>
>>>>>> Right so no direct clear blockers mentioned at all during the BoF.
>>>>>
>>>>> Nor any clear OK.
>>>>
>>>> So what about creating a device-mapper target, that's taking npo2 dr=
ives and
>>>> makes them po2 drives for the FS layers? It will be very similar cod=
e to
>>>> dm-linear.
>>>
>>> +1
>>>
>>> This will simplify the support for FSes, at least for the initial dro=
p (if
>>> accepted).
>>>
>>> And more importantly, this will also allow addressing any potential
>>> problem with user space breaking because of the non power of 2 zone s=
ize.
>>>
>> Seconded (or maybe thirded).
>>
>> The changes to support npo2 in the block layer are pretty simple, and=20
>> really I don't have an issue with those.
>> Then adding a device-mapper target transforming npo2 drives in po2=20
>> block devices should be pretty trivial.
>>
>> And once that is in you can start arguing with the the FS folks on=20
>> whether to implement it natively.
>>
>=20
> So you are suggesting adding support for !PO2 in the block layer and
> then a dm to present the device as a PO2 to the FS? This at least
> addresses the hole issue for raw zoned block devices, so it can be a
> first step.

Yes, and it also allows supporting these new !po2 devices without
regressions (read lack of) in the support at FS level.

>=20
> This said, it seems to me that the changes to the FS are not being a
> real issue. In fact, we are exposing some bugs while we generalize the
> zone size support.

Not arguing with that. But since we are still stabilizing btrfs ZNS
support, adding more code right now is a little painful.

>=20
> Could you point out what the challenges in btrfs are in the current
> patches, that it makes sense to add an extra dm layer?

See above. No real challenge, just needs to be done if a clear agreement
can be reached on zone size alignment constraints. As mentioned above, th=
e
btrfs changes timing is not ideal right now though.

Also please do not forget applications that may expect a power of 2 zone
size. A dm-zsp2 would be a nice solution for these. So regardless of the
FS work, that new DM target will be *very* nice to have.

>=20
> Note that for F2FS there is no blocker. Jaegeuk picked the initial
> patches, and he agreed to add native support.

And until that is done, f2fs will not work with these new !po2 devices...
Having the new dm will avoid that support fragmentation which I personall=
y
really dislike. With the new dm, we can keep support for *all* zoned bloc=
k
devices, albeit needing a different setup depending on the device. That i=
s
not nice at all but at least there is a way to make things work continuou=
sly.

--=20
Damien Le Moal
Western Digital Research
