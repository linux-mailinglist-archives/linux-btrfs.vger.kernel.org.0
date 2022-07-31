Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE7585DA1
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Jul 2022 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiGaFOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jul 2022 01:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGaFOK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jul 2022 01:14:10 -0400
Received: from mail.tol.fr (mail.tol.fr [82.66.50.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1593512A8F
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 22:14:06 -0700 (PDT)
Message-ID: <c2665619-1d8f-4c3c-f9b8-62bd36c0c344@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1659244443; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOBNesG4VY6mKXZGQf9JDL+2He5NT6fYVTBIDhEEUGU=;
        b=gt6/gsZw58SN1ub+KTV008A0hSUjndd7S3W7TtDmeXqDw6xlCdIzpkSKfKxCz49ts7IrmE
        iDkQI/DXN5J6vF2+0fu/hZjTAoGWt939ZCiVJEZWGdHBhNIQxszxy9TCmtDaQMlLGIb11v
        W6oVhwieWTIJfUOq+6s07Re1Eu+3DC/XJRca+gCfNuqkF59xK5UZTuEWumGzXmZU89NZKC
        aj0xh/8/yesPxi01PALqJSF88lqEgRG98XcWFmh7CTeNdgrd/czyym4P6ZcThS6mQkuDV4
        wLCDV6S80h90qI467iBPARBHTyfJwYu05WKTCsu1seU6aXU81eE2J3rZ4HgoSQ==
Date:   Sun, 31 Jul 2022 07:14:02 +0200
MIME-Version: 1.0
Subject: Re: How to get the lsit of subvolumes with
 btrfs_util_create_subvolume_iterator
Content-Language: fr
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
 <c2e7bd2e-e317-4741-5522-d7a311f5ff70@libero.it>
 <5d9e7395-1d8d-e1b5-5c1e-e7fe4c9b390c@couderc.eu>
 <55ffd61a-772d-97d4-0e5d-01d8a43bacd3@inwind.it>
From:   Pierre Couderc <pierre@couderc.eu>
In-Reply-To: <55ffd61a-772d-97d4-0e5d-01d8a43bacd3@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1659244443; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOBNesG4VY6mKXZGQf9JDL+2He5NT6fYVTBIDhEEUGU=;
        b=hFoZxcvq3RqTZtbhCWIg3G82xfuHsB3rYn+SM5djg7XeOQAKmi3M/ESEpZtr20j6z4Yk/Z
        p56qrASzjSETsWrSaijUXGfyl5paX6j14FQ9Z6dvc8ahjjLvyIxjQT/PgeuS0bydqdaEM5
        nMEZGvACfN8dVPflfbp/JrsTxVtOGKrf4N3S0ryEeiFgKoS5diDB/4kQZYjcgpWgQM4gyf
        DiJfdsaPwZlICPzYef9U4kk45MD03Jp9JQXqIkOyUpByOGcR0mgZtVF+Fi7ZI16yy7Ldti
        Mp+vWM2lkXdVoc1qRppbLKchXQNssAHqk9ia3R7bvd73hOF2P3mpVPfa4pjyBg==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1659244443; a=rsa-sha256; cv=none;
        b=O6HjMyKnGzXp/SJh0fjLFr6ZMUFbTEThKaK3zmmvnPQWXAalHdaPmmnMRcnZMbC1utoKZ2us+tdNcNFxDOtIu8FSd/hVkIx34bXCYqUrwkMEhvyOPca/KBsawwZXXyX1KfnTYG+06uIKKigzdOIgcTx09TYGKOQeyWg0Bd5YWoemNFHmS51oVgiRQM85dDYehcQ4wNneFcedOUlgqqlJyA1Oe6aYYfYzAuidTJ3SuSnIt9sL5pxwAcEK4PCfdc/V4eFlrzS7q2SCBp3j2nlTnj9u3djKVH+nLUT0i5CWow9xqFrxBkLyfpM/zbQn+V98jFbMOx0sw6reelgw/Drdnw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 7/30/22 19:43, Goffredo Baroncelli wrote:
> On 30/07/2022 18.29, Pierre Couderc wrote:
>> On 7/30/22 17:38, Goffredo Baroncelli wrote:
>>> On 30/07/2022 17.01, Pierre Couderc wrote:
>>>> btrfs_util_create_subvolume_iterator("/",0, 0, &iter);
>>>
>>>
>>> From the btrfs header "./libbtrfsutil/btrfsutil.h"
>> Thank you, I had seen other documentations, but not this 
>> particularly. The key is : "To list all subvolumes,
>>
>>   * pass %BTRFS_FS_TREE_OBJECTID (i.e., 5)."...
>>
>> I still do ont understand what is 
>> BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER but it does not seem to 
>> matter...
>>
> It should mean first father then children instead of first children 
> then father
>
>
OK, than you !
