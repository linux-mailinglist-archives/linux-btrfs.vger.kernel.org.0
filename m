Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4853565BF90
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 13:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjACMCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 07:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjACMCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 07:02:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D1300
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 04:02:39 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVN6t-1pLJEO3af1-00SRNL; Tue, 03
 Jan 2023 13:02:32 +0100
Message-ID: <22447f37-50fa-3914-a817-e95b66797944@gmx.com>
Date:   Tue, 3 Jan 2023 20:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: btrfs-progs 6.1 broke the build for multiple applications
Content-Language: en-US
To:     dsterba@suse.cz, Neal Gompa <ngompa@fedoraproject.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
References: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
 <20230103113941.GN11562@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230103113941.GN11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:23ObGQFcbsWtuDJauiGy3XZMnl83E76OSZrJLuh1slWBANS1Uqk
 rhrJjphR6TiNbSlQCJmztoL/M0orX/LoPKAxrM+vPZW4PyS06f16PnjMe9CB3jfg4NgRa6n
 DyyFyTA7Qj7cM2rww+TaZyhUNe6QF6roQns+uvQL7hvAzsAmGBR1RCmmXLsQiEthkyJp0yI
 aAuwJQ9GdgGAznM/8TaQA==
UI-OutboundReport: notjunk:1;M01:P0:B7T7hIcy41E=;reuC4cQkOzboXc3BjgEbAbk5jZ8
 SLpc2HLhwwZA5GTr0kXVwQejhG6Yn+3RJfZsRk2NpuZYp0HbNLA/texwsXU8XUivcvBneMZQT
 cs065+JHLN8bipyYeI9mbEBnsDC3/gxJncNm8otEqohnZJLsSpxI7EcAZm7qFwIbSo4Mzzp6S
 BlE4tN4F+FVVIiRqoOqPd4A7iYrLKhinqoaXs31SxrKnP+e+5a9uBtLvqqZzjLIKSjAIu5HlT
 CRhtJL5JipZOLOSk7CNP589/rSxH/Cl80+dPnOAheVTKLO90uovUdFnMEQu99qArZ2eY5E9wv
 Zy8HczaUJZmOKcHSuZk85+GyQGZNwwVUSEzZFn+sLvNRZxWrG2E0LshE/VSOHJ6LUYW5gcQkx
 qmc7vZAmkBi6siW6n1seuh4h9v0aTdz8rtuf3TCeowU4VYpHilXmKR1YlAnvMIPrtoWjPMfFK
 U6nUc87Yzm050Nmd1SmjbcQFsuuk01cnnaiy820uo+pqrp5rSmCSzdobFKEeoxTR97I0ryng7
 az7WV5021QPvH/BFUiMsT9pQqqVdfP4Uk4gdNPdq/WCKUq1kRigZtMEcIR5ZtUfovCjun4Nt9
 tz5ZjkK0SC/FX717XgDqo8/ZJNkRACfcXi/anTzHu2JHYIVYhgo8B42Fn2Ffre5M03joeg7t0
 mbsumDpLYHCDIXw8ng/iXJ+hR19uQjatRQJVh7iksqDsNy4kMpuyMbJ1F1Zg+vKFYgSBggJDK
 EzAG1Y3rCOigyN6al7I4R1T7kBV0S8b+TWrAoBkI7qRFeebqpq0l4eufDHPCcKqZ2i9w6vuS0
 Huw/wACKg6+Ci01Y0M6a7spKYzTZ7/9Goyqs9szMFaePWijECDGk23fRI9/CwXrNaxTP2rXSi
 ELG5Nl7R0g1PPzxGHSPuZtkrBtIB1FSb/0Un1kbzP6xdcdfLN2pLBBbl83V6Ntg6BorlUMePx
 M/2nXm/1Q6MIpfSDvshWLUHRn3o=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/3 19:39, David Sterba wrote:
> On Mon, Jan 02, 2023 at 07:11:57PM -0500, Neal Gompa wrote:
>> Hey all,
>>
>> It looks like btrfs-progs v6.1 broke the build for multiple
>> applications in Fedora.
>>
>> Notably, it broke:
>>
>> * btrfs-assistant
>> * buildah
>> * cri-o
>> * podman
>> * skopeo
>> * containerd
>> * moby/docker
>> * snapper
>> * source-to-image
>>
>> The bug report is here: https://bugzilla.redhat.com/2157606
>>
>> It looks like this change broke everything:
>> https://github.com/kdave/btrfs-progs/commit/03451430de7cd2fad18b0f01745545758bc975a5
> 
> On no that's bad, I'm going to do a bugfix release today.

I'm a little confused, why would those projects relying on the ioctl.h 
from progs?

Shouldn't those things got exported through kernel uapi?

Thanks,
Qu
