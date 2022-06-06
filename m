Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFED53F247
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 00:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiFFWxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 18:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiFFWxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 18:53:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C76A068
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654556021;
        bh=BUPENfxM+2ZDCL4e7wFn4nRcctKM4T+b26Co8FrFDiA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DgVs3QUtKTmp/UXlc3zSA9lH6x6jMN5u7PJgycQLryzfnLPQVetjSQQPpxYs7BIzj
         MylMZRinfgz5qg41s2jc+LLK9HwnjEZU6IJNkHk6tjz9jPNpnel+jBNAaR75TNwvmN
         Ecmwx37B6JnllUzpIn94GWTxrHeqf+HxZW0LKKZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwfWU-1nZYgY1HEw-00yA6y; Tue, 07
 Jun 2022 00:53:41 +0200
Message-ID: <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com>
Date:   Tue, 7 Jun 2022 06:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: simple synchronous read repair v2
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220527084320.2130831-1-hch@lst.de>
 <20220606212500.GI20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220606212500.GI20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DATsrFcJTC3g5NZNM3dtnoe0WKCBBoa33X4xT8bdA43jIT89FOV
 RK8s5MAVsReEHia9aYyqtnvrMg3KZB7v4EjrXrBhj6rlKDU6sbviG8lgUCTcRotgDKLe1K0
 c2g/sRzZkTdvoQdWUms2mzpv+ocCsfxHvnnMyZv3NEV+Z9R62ulGWiyrfBpeQOJ45k8stwq
 k/z8LCgmKkuTi+K27/smA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xe6WLwKdlKw=:enFW4VsoV8sedzkNt4Ubk2
 +L/kjnJuFQDEBhGe+IRovYO4sycyMuLgYsO4cpPX+yQRv7sWFeriT6Hl+XA8HdJIJAxsrYpcu
 oy5Rht1GJuXpV7bZ/RBxipMmP40LK87N1wCR0pbe0ZGO/YOV5btlfOqqQF7bJ60VgLIQmVSsr
 vTtEfOBCj9I0Gr6WGdDqMnGAQMTDto5zTvTezYqSVo5eoSrEXVDFFWOI0f/JzkWu48Zu6YVeO
 cOcdd7qQVxMDYB7cOqO+aPo0C/OzVGRz1zITn6Vesyb6rmVyscPsxmFRwKRqiKaSp+yn11M5h
 POBY5KhW7pEgfYBDPBzWURv4IYkRO6BunJuRY/sm8gW4unqt8ILYNJu+nVr3S0HppSkqWL+m9
 FMkXd7JSbQXSiFiWdinQrsKToj/HOnKklRJiDTs30LSImeSY5lXREiqyU7IgbSAtdYNurWO8B
 fSglVZX4kGAlJajzIAq3Y7pilzJSn/tggxWt+ynXAiE/5EgxlEwLLwL7a+4ZuMZbp2t/P7iAI
 sbCIi+iQbcM2jcKxFiGrUL0EaCC1eRaBAFr8p9kCDd74+QnvTGYIj5hGbvA+giozUbHz2YBGc
 Z1NAavte30FvGAcKVt4//TL6JwA+OQ6RyP0Di+YHfJLrkPEjwSFYQVZYTp9fPhkclW99Bfv1m
 onPebaa3PBt/W2CNNmUjmpcmgFT5b/Ov80C2ZlsZxMG5mo7Xsx/NVy2UPy2O1nrJESqiJGPW8
 GZWMYL4jMHYeobh+KcPw+Pd7gX1VNvJHElsu6TbALfZ+3Zr+Jtw584fdczFlJdGixe2Q3dX/U
 mUXk7vZsDSZGYI2xcJEQO6j4sFtoA0mnrnVaLS10RHpHHE1KgZ7/E+cmC5nt2D/0lYT+aMu52
 /4RiuyitctuGn5xi+2ORpSzEqKTjjsk/GwOzW2YElOMfiQtmPZ/v9L/VRWV2+t2mHa8Wx9cRM
 kU7gboF11kQBM9JaS95ScFLbKmP65DJYpYzDQcezkeclMH5+uU7k1N7W05ts5Ega4Gf1wgRvf
 We/mqQ7E5DJLjI885OOdjJpLZkhPwC0cly143mmvW1lLBZv8E/49Nr/iup/CluRe65yapB3Q3
 /RwG9SU1M2xBbVUIcFsy3HpncHOVwlCyKrTTBWE1PdO0Rb52MtnuwvZlA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/7 05:25, David Sterba wrote:
> On Fri, May 27, 2022 at 10:43:11AM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> this is my take on the read repair code.  It borrow a lot of concepts
>> and patches from Qu's attempt.  The big difference is that it does away
>> with multiple in-flight repair bios, but instead just does one at a
>> time, but tries to make it as big as possible.
>>
>> My aim here is mostly to fix up the messy I/O completions for the
>> direct I/O path, that make further bio optimizations rather annoying,
>> but it also gives better I/O patterns for repair (although I'm not sure
>> anyone cares) and removes a fair chunk of code.
>>
>> [this is on top of a not commit yet series.  I kinda hate doing that, b=
ut
>>   with all the hot repair discussion going on right now we might as wel=
l
>>   have an uptodate version of this series out on the list]
>>
>> Git tree:
>>
>>     git://git.infradead.org/users/hch/misc.git btrfs-read_repair
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btr=
fs-read_repair
>>
>> Changes since v1:
>>   - rebased on top of the "misc btrfs cleanups" series that contains
>>     various patches previously in this series and the
>>     "cleanup btrfs bio handling, part 2 v4" series
>>   - handle partial reads due to checksum failures
>>   - handle large I/O for parity RAID repair as well
>>   - add a lot more comments
>>   - rename btrfs_read_repair_end to btrfs_read_repair_finish
>
> The preparatory patches and other bio patches are now in misc-next, so
> I'm adding this branch for-next. At this point I'm cosidering this for
> merge as it has better performance compared to the simple repair from
> Qu, though I still need some time to finish the review.

OK, although I'd say, considering the latest read-repair test, we may
want to simply the write part, to only write the data back to the
initial mirror.

Thanks,
Qu
