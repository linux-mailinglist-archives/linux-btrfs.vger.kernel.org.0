Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967E53F636
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiFGGeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 02:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiFGGeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 02:34:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AEB3123C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654583648;
        bh=FDgYpzZN2h5VC7kdaIF5MRrXQe+FDTmCtQO5zbCrEtU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cywfSl9uo71Aml6IJEZoXckOeYVyIMzmn5vlprnBIJFIDjWcF1p6GEPNUoYXR6PC+
         8mioT7op0GiEjcvMhCCZR7V305y0NYZyzQcb4+z4lcu2CZ4u6tQydUcamtwxT9397W
         /sAEA6S7CSDJUSgvY0sIxa4OXwBI6hmioWarELLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1o35MU1qYj-00DVTd; Tue, 07
 Jun 2022 08:34:08 +0200
Message-ID: <14810ca4-9af6-3bc0-429e-aeddb341aae4@gmx.com>
Date:   Tue, 7 Jun 2022 14:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: simple synchronous read repair v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220527084320.2130831-1-hch@lst.de>
 <20220606212500.GI20633@twin.jikos.cz>
 <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com> <20220607061622.GA9258@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220607061622.GA9258@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTYUeLnroq7CednFcAUVJ/HU2zJKOZ7383ppysHOCqi9JhbTUkF
 Jqh7bn6EceqxkPkBjs274jxNZdUgTu9NjpOevrRepzBct5pjuH7EB8Mb6vU/DYhhVMHzREu
 1oTBfzRCPYDTc8gkEEaPEGIgveyKkYuIYyTuUMxzqy8bwHB65Iq7ew8VaorkRM3D6rtXyHj
 SoEDH6J2V4JgVPRjvsb3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F7O4Rae+QhM=:2jc8K8EgScmXSF+eD4rfZ3
 mNU06ocQso8SoBaKIsmuPoMkC6WziqlQdAjYqpBTA2XxId29HMP3uKKN/XlQLEwlJYkuR1gwm
 30Ekdf0QsX4sXrz8qF+UZOAq/eT/U3wE9P91MawUE8/kO6gqD3wv1c+jz2kDjkGIHjD+pvKOh
 ZfC3dKO3IC8FBkLioX14DPXvEyAuf2INw1atxIvXBLhR0+g5mFvxGg5pKA7518vgOhLR4D59Q
 P8PRLdaQSopGZWnjQj2YqQGU/UtozWNG565S/IP6oRrOqqzCdmgwxmCs8rIYb5g+ig4UklVrD
 O+EjQECXgYXuNSTv/yv9dOpJ90ltn/vCBed/6kaK6jw8+oQ8rzH3AzcCKEMAFToUIH9qqZolk
 nthFpCckT2ev3Gzsf0866Pp7v4XvC/eBLZIYOL33cChzdX+cA5bI9LZ+RJdjbfg0cEO64LSQH
 v/2vBF1TU+2QNJLiYuLLGYQwVq5qirVy/eZfNxOzod4BLbUy+ZK3lHrZdyop51sWykpQWHcoN
 /CBy1DX0c8cJj8g/zstE2l4xNPtRxxTDXgh9L3Uz0fRttGtv0pYCjh4LnZcUoiyObDZolUfFV
 ZTdsknoLY03dQvNpX0aJd5nKJN2CuUfLYRl/ZJcNh4bu38WOJqCqhL1ArMzAFdGivBCzZkl4E
 I4QRTpoEin8w7TMDFnQSwYn0Hql8DF/+tulimItY28CmSL3FP9dk/bRK+APTKHNssI6vRvDY7
 OnMTwCJokfYjCNnf/o+TBtcq9shCvXM4194gUXFRWBzysuu1d5DGZq1TRlRPxNjZXhx9Rp/sp
 +v8VCFCx+gHCUQFWWay/cRUT9GjgZr3cs8cUMS9PhGS4iAMofWlfWcrzaWEYH/sLL38Eaxtc+
 Godx3fstJZ0GOzjYd1os4lNZSinYdpHRqje+Lnpfv8GbMaq/Cpoh/mypdqhl/eta86/NPYEXS
 aAhTcXSOWo8PDo2gD4ebQjwhz4A/ECS0dP6wXRCN81KhbVcSC/foelhWN4hIszwFqQ5iYd95V
 C1kUQW4soStt28V7+31i/8pRBTxrhQLOAk6jaIrCD4wP4ZOa/UJ/2nOQwNZ0XxcoDBMFWx4Vs
 MYI8jikN6vpTwxcwN8Rx/0FzJjzXxa/Bhkk7U6bcHiCFiVsFi4V+28G5g==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/7 14:16, Christoph Hellwig wrote:
> On Tue, Jun 07, 2022 at 06:53:35AM +0800, Qu Wenruo wrote:
>> OK, although I'd say, considering the latest read-repair test,
>
> What is the latest read repair test?

IIRC some RAID1C3 cases like:

https://patchwork.kernel.org/project/linux-btrfs/patch/20220527081915.2024=
853-9-hch@lst.de/

As currently, we only write the recovered data back to *previous*
corrupted mirror, it doesn't ensure our initial mirror get repaired.

>
>> we may
>> want to simply the write part, to only write the data back to the
>> initial mirror.
>
> Why would we not write back the correct data to all known bad mirrors?

Because then you also need to record which mirrors are bad.

I doubt you want to bring a more complex version to write back to all
corrupted copies.

And in fact, only writing back to the initial mirror is also going to
make recovery faster and easier, as now we only need to do one
synchronous writeback.

Thanks,
Qu
