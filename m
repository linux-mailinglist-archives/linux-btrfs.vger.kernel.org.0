Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F45541C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356656AbiFVEbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347603AbiFVEbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:31:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213035272
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 21:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655872240;
        bh=JecFtdqLkIDDZv3Kx1nLsTzr1NZCKrx1pR9+5K60Z7I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Enj+TwXlZ5Q7mlR2J6vboyD7hEJ8OT9faL+ZTfGugcAN6XulgLUjmF/Ytz3VGi4dq
         jHH1ZFXwsBmQFpxGNF61xM2EUucFXrfJO9DBBLHGaC8PpU0KfkqLOQiHNxpRXz+usG
         g7kEHpOxjbPtI6VneFEiagLZ5IAKt4TAERJk2oXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqaxO-1nHLuJ2jCa-00mYLG; Wed, 22
 Jun 2022 06:30:40 +0200
Message-ID: <e4e70712-f85e-f565-0c07-7bf778fec9a6@gmx.com>
Date:   Wed, 22 Jun 2022 12:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/10] btrfs: remove a bunch of pointles stripe_len
 arguments
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-2-hch@lst.de> <20220620171608.GU20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220620171608.GU20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZZbRt/egVAZcgeBLdwUtmgSwkn6cPle6jbpt1RCsoYCn9unurdk
 QO3rPzhUMFRZ51J0mrGVnhYc7MWiJN9Rd5HrvSEz6zP9Vz7gpV4WMgozpxEZmiqXks1njiA
 QdMo3vPv9k991CPtN1aqJXChyCiUvrEaAEnid8EIw9hmHVX91yv881FPjyyhUG7Eu74FP+j
 26H6amM9i1WAH/ntnz0Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ur7uhieEj78=:KXFnZ/44YgqmnHC+0GrguG
 XfclLCVME5QGLjgfeJrla1+YeIWvhb7lNicnbTxFZ7QxHLGpWzUua7yp0muwDcTWLScWX/8tp
 OCIVoPO86IbxUie5vbFQOpGMuwA5mA1cL0IGBuOVcmdaIRICMls0jhNhOXcUNEd0Yt9vSXWUz
 95d9ydgV+kLJN+yenLCqEVhVPSDyAJyg8SER2Wod30hXk8D93OiDRF7c022nxssdiOLkLuO5R
 cjbKjBnEZxTfuI/MQ1AVFXZym33ouhWfv0dOOmYrV8ykXmeaFjsBQmJis0mZuQ6D3mNwOmYvd
 HOi1dkem83SXfs58qHWwP4P/OdTPzUshoWO4wYSedCbkLQZitBnc0nuBSWz4Aphckhy1mLrLo
 xD5G2wBYo38CHAVlR2Q7K6mZBzUIRQ0xt4KkyD8B2KLhUzx5WYNUWGSLSa/M5daxPbjaHpQCW
 pQru/NQvhKvofc8XsEifnK1S7hVvkbhyGbr38M2bg3Fi8DkY+JEghqB9F863omK4xnQ8IDv/J
 hXjotLNOeJ5kxprRljfC/KFAP/a+QwoWNFY+zGTy203lrzDlGbsOrxk2QxxOg/iDk+cpdmh3V
 MPl2PY3d4JF5ezFi+Ozmv9KwJvQxQDFtM63tESLVDWKYktleS+kGom8NUS1LIvRcEXtgY5b1B
 lUM0D+V5ScH1ob0Z2V8iIHqUbuLuIe/y+5Yl1h5xxZ9w+dVYXTIT1q37n+6K0Xs77Ldjvli4h
 ZOKopr0fw8h0m+Ir/iC8pFX6uNtDuQjS1ziPaKn3Yt3GdgRQhwe2YqDErvtJCQBm6BxQgKNXv
 +5HvpzX86v/bx+1+XMBDDxlc/ShrIdNj/3PhpBG7XQfgELLRtCV7AnFctN7J775E8iAK6ZTdn
 fTKYwrjeHknKhZ52bJTcS2ERetkJ+kV9yyoEsuyaLGTmV5vMLiw4sK/SHuNy8fJYOMnDzhiq2
 GgXyrAGr2JFSLMva0Rodq4fChPx+7vhPwTawfELOzWQhlbzPd55sq+arGcnUYNz1nLmsygPIf
 SXASwmofuwtZMCkzt4Syb/oTleyv0tiKKqeG1nflzQ9pkSDhu3/F6dSZev0hx1KSdfDFFAs8c
 0DmvNfvnRXDyIKQbjpOzd11A2pfYQPXcxSABmmGhMMqID4oRv2pnrB1UA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 01:16, David Sterba wrote:
> On Fri, Jun 17, 2022 at 12:04:05PM +0200, Christoph Hellwig wrote:
>> The raid56 code assumes a fixed stripe length.
>
> The code does because it was part of the initial implementation but
> raid56 as a feature wants a configurable stripe size, we have a super
> block member for that. So the question is if passing the parameter is
> such a burden so we'd rather remove it or keep it there though it's a
> fixed value but still part of the design.
>
> I'd rather keep it there so it gets used eventually, we have ongoing
> work to fix the corner cases of raid56 so removing and adding it back
> causes churn, but I'll give it another thought.

Nope, we have too many code relying on that fixed 64KiB stripe length.

In fact, tree-checker has explicit check on that, which means there is
already no way to be compatible even if we add a lot of code to support
different stripe length.

Older kernels will just reject such chunks with different stripe length
other than 64KiB.

I'd say, we had such situations before (mostly for inline dedupe), we
just introduced some dead parameters, but in the end, no inline-dedupe
at all.

So just don't waste time on something that no one is actively developing
yet.

And I'm pretty sure that, even if we're going to support different
stripe length, we will need some compat RO or plain incompat flags for
it anway.

Thanks,
Qu
