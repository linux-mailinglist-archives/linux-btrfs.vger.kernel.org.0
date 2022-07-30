Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81E585B48
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jul 2022 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiG3QaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jul 2022 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiG3QaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jul 2022 12:30:00 -0400
Received: from mail.tol.fr (mail.tol.fr [82.66.50.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF49630A
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 09:29:57 -0700 (PDT)
Message-ID: <5d9e7395-1d8d-e1b5-5c1e-e7fe4c9b390c@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1659198595; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqeWqqVShEo/QBSKBM/2cA+C8XXFxwPIIhNvFy2JJ/Y=;
        b=bkLW59uKI+YB5FI/tlB+zXIjZiwPJW3hQjNEd98Uhq7aj1xHX+Ivw5vUomfzG5ZSAGRj0m
        qP4OXWRe51IrtuHqUdk20AtOHWM6R3i1dg2stJBtf527HuRncrhOYeHhfWamg/Z/WzqehU
        CE7hOM7qIQc9lPRZwzsmw4rnnnD5OUZLFmsqOsk5RnyPpkqNZhxYLqdXudAMsnkdac0E+k
        09ydKxR/b/I6No4DPHI27I2QNOmIIY9f2aQL3wbXw6njVHjCIOvU+bjIJOuFUJ4smySGQM
        APKSv17gV5G2tcEpnkJ4Pm+Aq495EEqjpTKsHvHUwyeMWSpBQxflmloHd++GJg==
Date:   Sat, 30 Jul 2022 18:29:53 +0200
MIME-Version: 1.0
Subject: Re: How to get the lsit of subvolumes with
 btrfs_util_create_subvolume_iterator
Content-Language: fr
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
 <c2e7bd2e-e317-4741-5522-d7a311f5ff70@libero.it>
From:   Pierre Couderc <pierre@couderc.eu>
In-Reply-To: <c2e7bd2e-e317-4741-5522-d7a311f5ff70@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1659198595; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqeWqqVShEo/QBSKBM/2cA+C8XXFxwPIIhNvFy2JJ/Y=;
        b=W8MDLGP7ypASYAdYq6dz1dk2rcgxt4iJ9vKES3oca9BB6gl90mTwZTVuY9YC712edUv940
        dFrpkm5iFvW5NffuhRHAkaqSoHOVfwNObcVGCTRB2WmYPztIuyBT0bGzaQ2ZYcwXvNOWnq
        SqF1rqx0LRy0ivlSihbBStlzxV7oG3MEQYzwOdD58hyykAj/EQqWFwgBaNPjOEPO/EPGVz
        FHp1pKR7Wb0WlxwT2i/I1Opd+cxN74vUaKHRVxY7FRXz4WATdtqnbdQBLAJil10W7MKX8B
        127wftgk6walG/PavbM/1I8pIoqobMUsRmn4WHTUy9oGbIBdtS+DAMuYy82k1w==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1659198595; a=rsa-sha256; cv=none;
        b=hS+H8NNGaOAQyQlO6XH3ekeeX57gmmGGN7Vp8GqLhvc4w0ZTJfb1bb9SCk7GeQKjDx3CWQaLjbIoL+gf6YeSLi3MhrtOfxbK9GEZgAEUK38swJEROOIuZb24UsgKkgGTjUQbaBJjlxtLWpOzpYgCWKyBwvUbpE5FGdSHkAUZsUG2OjWCHyshvGncqkIeavB7JUsZL2yjoJsRTdTjM2xVJM9t64Dw1m/0eVG6m2u0lvjq3W+KSwpThhlYA4clG2R0yWBMv9k9PZm6uXfW6z+qT8ZlestJ9eS/ac0dDOQ66s9XRLzY9zObIGRDO7gtTvxaCYg1Vd5J11qZBEj4FgBzAg==
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

On 7/30/22 17:38, Goffredo Baroncelli wrote:
> On 30/07/2022 17.01, Pierre Couderc wrote:
>> btrfs_util_create_subvolume_iterator("/",0, 0, &iter);
>
>
> From the btrfs header "./libbtrfsutil/btrfsutil.h"
Thank you, I had seen other documentations, but not this particularly. 
The key is : "To list all subvolumes,

  * pass %BTRFS_FS_TREE_OBJECTID (i.e., 5)."...

I still do ont understand what is 
BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER but it does not seem to matter...

