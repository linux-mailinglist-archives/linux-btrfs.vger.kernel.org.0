Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027FE54A990
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiFNGgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiFNGgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 02:36:23 -0400
Received: from ts201-smtpout74.ddc.teliasonera.net (ts201-smtpout74.ddc.teliasonera.net [81.236.60.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1FB437A93
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 23:36:20 -0700 (PDT)
X-RG-Rigid: 626BF61301B23962
X-Originating-IP: [81.226.241.77]
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddukedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffnkfetufghpdggtfgfnhhsuhgsshgtrhhisggvpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepvfhorhgsjhpnrhhnpgflrghnshhsohhnuceothhorhgsjhhorhhnsehjrghnshhsohhnrdhtvggthheqnecuggftrfgrthhtvghrnhepteehudfguedvffeiudfhhefggeduleehheefieeviefhteehgfeutefgieffheevnecuffhomhgrihhnpegrrhgthhhlihhnuhigrdhorhhgnecukfhppeekuddrvddviedrvdeguddrjeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepghgrmhhmuggrthgrnhdrhhhomhgvrdhlrghnpdhinhgvthepkedurddvvdeirddvgedurdejjedpmhgrihhlfhhrohhmpehtohhrsghjohhrnhesjhgrnhhsshhonhdrthgvtghhpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghnughrvggrrdhgvghlmhhinhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrvhhiughjrggrrhesghhmrghilhdrtghomhdprhgtphhtthhopegtvgefghekjhgujhesuhhmrghilhdrfhhurhhrhihtvghrrhhorhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgr
        nhgurgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdprhgtphhtthhopehmrghrtgesmhgvrhhlihhnshdrohhrghdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopehrmhesrhhomhgrnhhrmhdrnhgvth
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from gammdatan.home.lan (81.226.241.77) by ts201-smtpout74.ddc.teliasonera.net (5.8.716)
        id 626BF61301B23962; Tue, 14 Jun 2022 08:36:17 +0200
Received: from [192.168.9.3] (tobbe.home.lan [192.168.9.3])
        by gammdatan.home.lan (8.17.1/8.16.1) with ESMTP id 25E6aEUo1481056;
        Tue, 14 Jun 2022 08:36:15 +0200
Message-ID: <b5980ee1-f033-c6cc-dd98-ac047451ddb2@jansson.tech>
Date:   Tue, 14 Jun 2022 08:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Suggestions for building new 44TB Raid5 array
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org> <20220613022107.6eafbc1c@nvm>
 <20220613181322.GP1664812@merlins.org> <YqeZJ1j2ZYGpvY7v@hungrycats.org>
From:   =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <YqeZJ1j2ZYGpvY7v@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-06-13 22:08, Zygo Blaxell wrote:
> On Mon, Jun 13, 2022 at 11:13:22AM -0700, Marc MERLIN wrote:
>> On Mon, Jun 13, 2022 at 02:21:07AM +0500, Roman Mamedov wrote:
>>> I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
>>> can add and remove cache just to see how it works; unlike with bcache, an LVM
>>
>> In case I decide to give that a shot, what would the actual LVM
>> command(s) look like to create a null LVM? You'd just make a single PV
>> using the cryptestup decrypted version of the mdadm raid5 and then an LV
>> that takes all of it, but after the fact you can modify the LV and add a
>> cache?
> 
> Some variables:
> 
> 	vg=name of VG...
> 	device=name of cache device (SSD) PV...
> 	base=name of existing backing (HDD) LV...
> 	meta=meta$base
> 	pool=pool$base
> 
> Add a cache LV to an existing LV with:
> 
> 	lvcreate $vg -n $meta -L 1G $device
> 	lvcreate $vg -n $pool -l 90%PVS $device
> 	lvconvert -f --type cache-pool --poolmetadata $vg/$meta $vg/$pool
> 	lvconvert -f --type cache --cachepool $vg/$pool $vg/$data --cachemode writethrough
> 
> Uncache with:
> 
> 	lvconvert -f --uncache $vg/$data
> 
> Note that 'lvconvert' will flush the entire cache back to the backing
> store during uncache at minimum IO priority, so it will take some time
> and can be prolonged indefinitely by a continuous IO workload on top.
> Also, the uncache operation will propagate any corruption in the SSD
> cache back to the HDD LV, even in writethrough mode.
> 

Personally when i setup lvmcache i always use the "all in one" command to 
create it.
And if i forget the syntax because the man pages are a bit unclear on how to do 
it exactly then i got to: https://wiki.archlinux.org/title/LVM#Cache
for a refresher.

It is something like:
lvcreate --type cache --cachemode writethrough -l 100%FREE -n root_cachepool 
MyVolGroup/rootvol /dev/fastdisk

i usually change -l to -L and specify the size of the cache there and the name 
(-n) is not to important since the LV will still be named just the same as 
before the cache was enabled.
so this name is "just" something that shows up in for example lvs output.

only type=cache allows you to create and remove the cache with a live 
filesystem, the other type writecache requires filesystem and probably also the 
lv to be deactivated.
don't remmeber exactly but was more effort to turn on/off writecache vs normal 
cache
