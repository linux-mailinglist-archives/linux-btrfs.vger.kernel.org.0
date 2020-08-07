Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096DF23EA74
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHGJgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 05:36:43 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:17710 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHGJgm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 05:36:42 -0400
Received: from mail.tol.fr (unknown [IPv6:2a01:e34:eeaf:c5f0:21e:62ff:fe00:36])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id 733E55FFBD
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Aug 2020 11:36:11 +0200 (CEST)
From:   Pierre Couderc <pierre@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1596792970; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=FKF3imQsYA6rfNqHdDJSItny2zYqrMe2EA0oVix41ms=;
        b=Pipb3zOfSOiyA60DhGFb+TJVrWz47nP53vEkN1D+jFcgWMZSHmm0ujVP12XmK+Y66AVIRL
        1xk3ZqrVHMKbBZQgrhOgJo9gZixStfKKncKjIfZ3XY4xe63RW8ewV8jOogppav14oFwMWv
        0AFmZTwjxZXiGZ7gsi6xlacrXVt4SDVPr5W3huBBrE/CG0dhpseZO6YPZUxcriBh7ooKpO
        DcMDrF9yabxJ9UFUlBOKZmJVvKc03DRpuG0NzwBbRSG89zgO89JnaCpnaO8BxnFCYmCJWP
        65UObKAYDsOr6XGWwLTPITnrQX/fCZsxKL/9EOe/FC73DnHMy1XBLEJe89rcsQ==
Subject: Is there some doc or some example of libbtrfs ?
To:     linux-btrfs@vger.kernel.org
Message-ID: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
Date:   Fri, 7 Aug 2020 11:36:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1596792970; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=FKF3imQsYA6rfNqHdDJSItny2zYqrMe2EA0oVix41ms=;
        b=omICHqxE6aiybRdKVhtuE+HHK5NSJuD9PBKgqYUqdHnDYbt+V/dIsjwcR5WD7iMKvw3pgR
        TozGNyrNq4ZQrQlI6zD/F8M07xGe0Xr/LAwhynjq3j5kbqAWHldO07OB2RWb1oaUCgc4Cc
        THoHLbd0ApnF7Nk9SbleDkzQVCW6getAdWHETxpVBsjvSa0BP1wKHnLK33nvLIcrA2u5Ch
        MGxdcfge9+GmQMaebJ+LshHhkL07hR07IuxyZfhDS3Sdf75RU/jLuEmEsoCet68x41wsaF
        GZP0ULgahfTtSukTsz9026mAGNBk8rT/tOBqcQQKBjFZKV9D2u3GXkBlcrnqPQ==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1596792970; a=rsa-sha256; cv=none;
        b=tnmLFvD06AGTPBr4p2OVty7vlgPjqjHwLPI09MjI/nL0hNtB+4s0dxBEcCWp6O2M2S7bxmGe14be2uI6u5Y9JopQ7npAs5a9P50F5OA+oZa+8rLQiyCTVnEmB2dIXl/+QvNpej03uBR6NNZlpk8nw5F3wj8E7gf8L7wtqfW5owbGsmskshLhPg8+ZqChK/0D9Wbh9VYQ/BaJ8Y/9h2BhPUpkOvzr5nJCLUOF0q5CbdlOT9A9RmakPQxBaeM4GuJrOaiZMkp75EkjHeox9CraY/zyOygeMhBINgPkqHIQJvMpzYrtfjYc2eN2ilDj0TMwliV6YBN6KeXVDJPMfgMnmw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ho do I get programmatically the list of the snapshots of a volume in C/C++?

I can analyse the output of "btrfs li sh", but is there an easier way ?

I have found no doc or example...

Thanks

PC

