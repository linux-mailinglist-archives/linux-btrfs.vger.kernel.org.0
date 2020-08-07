Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2B23EBA1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHGKiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 06:38:14 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:14496 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHGKiN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 06:38:13 -0400
Received: from mail.tol.fr (unknown [78.234.252.95])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 8FB6EB0059C
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Aug 2020 12:38:11 +0200 (CEST)
Subject: Re: Is there some doc or some example of libbtrfs ?
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1596796691; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOa6DDdLpkHArbl0myOdB+YKly2vC+QfgPW2XSCIGeo=;
        b=i8Q1vIMu/gYiqhhGbUydGNsN0Ukj41FqQXAMLP00MLkxHRxmYFJNPInKJa32r/gI+twM1l
        fuB8DFG16/jQ8Qu162LXxOCMCAyKUkP5j/eQRo6qLpFRzGa11yYeZJLiA93lIJU+G3TxPP
        0IXUky6L2y9PgC/MAwBQtPtU/2UCyehcDbih1GE48nNmGXP/52LDItQHQnOrAytfDZ8dw6
        coOCV52A+eoeX34yCwJKVIsvWqx5f/CVMFnAOmDwR2GhIrJ5oNs5+UBazH06dTADqPMw2A
        ePVifBZ9GIJ7JRWK4FUKe3NIQLwuKP36fDXd5ChHHH7BJurnBKFfp1tPA0sEQw==
To:     linux-btrfs@vger.kernel.org
References: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
 <4700f999-7914-0453-7096-f2ca360b4be7@suse.com>
From:   Pierre Couderc <pierre@couderc.eu>
Message-ID: <7661cb47-7a56-51fc-b4b2-0dc3e5c6d5ab@couderc.eu>
Date:   Fri, 7 Aug 2020 12:38:10 +0200
MIME-Version: 1.0
In-Reply-To: <4700f999-7914-0453-7096-f2ca360b4be7@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1596796691; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOa6DDdLpkHArbl0myOdB+YKly2vC+QfgPW2XSCIGeo=;
        b=kJxlvJKQ+q71cpKmfmvG8yS1+JQLeDQrmYHD1fKvPM0veXDnJ0d1XkhiJ08XwbC3OuZSqZ
        KDYeH9tFP1C410O71H682qidMx2RKsvkD5FmpC4GiMaYUtDQ426aT6K4xmhBV4KpBJmXXH
        2DylVHJTDXr9pBgfbDiXKsDtxLavvcombcMfPCN4naz6pMK7OCe18cAuCASmWMPRGhA9uT
        bsbuPwokoXXqxgziAR+Z4J7y+aZlCfUlMBRxwfUUDDfmA/7MSPvYsQDh/pz1OlK7etnQw3
        +KuZB5RZ+lSR2VOcjpZLXPhMbJexsokOM5menKsp9sDGjmEvA/Rx7ph9jGBT8A==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1596796691; a=rsa-sha256; cv=none;
        b=E4dG/vcsC7ImQpmItghL29cjVJqs6F7RUi1qk0WKvBo86ggARQ+J44DG6c6JE3YNXFa1TnkKFQYmed/GMHmrwHUZOeXRoSGDEhTiWgnb1g6kCjl30X/zP1+1Rd0NKW+GY0E8wXIiwAj9PcPgDxlUNZZJEv2oZmi6Wu4BUfJX2goLRz93TL3Hshn0ZeiLWa417cbfR6gib0gjp/K3PpXn3Ipi/2BhVT5D51+uZ5Ix/AZKrTRBH0+JnsFGpZSQc0OcOIHwfI5DsNr47GhQ1AUNgObLGk71wPSL7GTHWgApnPNuTMGDYGZHFza+cSVB7E3g8kJuAyP48fooxy9PSvw6Fw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 8/7/20 12:17 PM, Nikolay Borisov wrote:
>
> On 7.08.20 г. 12:36 ч., Pierre Couderc wrote:
>> Ho do I get programmatically the list of the snapshots of a volume in
>> C/C++?
>>
>>
>> Well, the example is in the source code of btrfs-progs, namely :
>>
>> btrfs_list_subvols_print
>>   list_subvol_search
>>
>> TLDR You'd have to use the TREE_SEARCH ioctl which allows you to get
>> data from btrfs' various trees. In order to figure out what data to pass
>> to  the ioctl you'd have to familiarize yourself with the internal
>> structure of btrfs trees to know which items represent a snapshot and
>> which proper subvolumes. You should check the "ROOT ITEM" description at
>> https://github.com/btrfs/btrfs-dev-docs/blob/master/tree-items.txt to
>> see when a root item is a snapshot and not a subvolume.
>>
Thank you, you are the light in the dark..

I start on that.

PC
