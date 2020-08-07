Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FB23EFE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGPUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 11:20:40 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33315 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGPUj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 11:20:39 -0400
Received: from mail.tol.fr (unknown [78.234.252.95])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 833FCB0052C
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Aug 2020 17:20:37 +0200 (CEST)
Subject: Re: Is there some doc or some example of libbtrfs ?
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1596813636; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AesxEdbnRgCIBKCTt27gaj0x/fIJgLP4lwLxvhPWmNA=;
        b=BUrvqEP8yARAxGY9+9tEgj2oDaEnBNfMjJFYzM8oxGyyWr0j/zlmxP34WJdWrCbSlXPwQ3
        xaKism73LiMumqWladGhkvr7go3xgq7Tsbtxw/Uv1NEk/KAsznCSRQHT35Wt43PRYGf8Uf
        llonu6oslM2fp3RzNKZ7zK9zqGeif804uJDUpOZssJhiLdOnbmfQE4sAkmW9pgqlX0rVO2
        r6xcV2A46sDgS0wysBNDkC8bL7orjj/ZwsK2q1daSzoR1uipag4epLVbnHHxG6Boc0NZ7q
        SUXOFot0JJ+TOcGCfw/Jab+Rf1Pna7+tm/IxEy31ovm0yHPUXkQ0FVruuqdX7Q==
To:     linux-btrfs@vger.kernel.org
References: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
 <4700f999-7914-0453-7096-f2ca360b4be7@suse.com>
From:   Pierre Couderc <pierre@couderc.eu>
Message-ID: <37ddafc3-bc69-0848-ab8d-4c05d8a686b8@couderc.eu>
Date:   Fri, 7 Aug 2020 17:20:34 +0200
MIME-Version: 1.0
In-Reply-To: <4700f999-7914-0453-7096-f2ca360b4be7@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1596813636; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AesxEdbnRgCIBKCTt27gaj0x/fIJgLP4lwLxvhPWmNA=;
        b=C9GnMmelFIoUgJXh0DzsshJFy368RzsTzhF7I7sq325nI8FEXz2mn9HSSEV1fDFVK91HuX
        GBKrbz5guS9CeWYVL/5ZC1v5mXBLDdCGQxLN4+xpRINBSPCNyKZ1rwu4MT8BAmeb0q5VbB
        qBT4RSpjUKlo6DF7bgfFtwkbkPntFv8I6hlqA28hafZW8v5f0T1R5umqSFVfamy8Wcxrzb
        anmtE1+zGdL3I7kYq1qDV+Eo0+Cntyjuy44rtmPFepJZDeXK3hdqkKqBuFZeawPLuS9xJU
        F7EX+Cum93NAV0Bfr+WwZ9AGj8g7qxGub/+VkIAfT8Lw6uOrUxjB5ZMvK0ZWeg==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1596813636; a=rsa-sha256; cv=none;
        b=rAJGvmmrivlI1tBIJvevbl3T44ZM6HwLu4/GJFw0NtJ1jg4dKvu2tIfAMEZI3DFRsZFPzw7saSou6w+MYBxUqx1A6dat4vL/gPIfhteirFRwRTDNPc8G3E3oS3RKihOiQSoJtf2Ap3xxUAL0ab5RuzLL7E1YXxj2vy8CHP8NEx6X4PoDrocy6kZCCYcQpeBo8P2M/2qh7spmn4ZR4OG6+DLOQUmSapeUCA7fJOBGjb/dApfzvCIN1Ic9ILTWCNjNRUMcLClShbdqp9AHwtnPjz9csxBZ+hP/wmyrB7FndEAMm1WRSZKrylaH1faT8+eHV/9Fmh4ZMPE+MfLHoCEPXA==
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
>> Ho do I get programmatically btrfs xxxxx....?
>>
> Well, the example is in the source code of btrfs-progs, namely :
>
> btrfs_list_subvols_print
>   list_subvol_search
>
> TLDR You'd have to use the TREE_SEARCH ioctl which allows you to get
> data from btrfs' various trees. In order to figure out what data to pass
> to  the ioctl you'd have to familiarize yourself with the internal
> structure of btrfs trees to know which items represent a snapshot and
> which proper subvolumes. You should check the "ROOT ITEM" description at
> https://github.com/btrfs/btrfs-dev-docs/blob/master/tree-items.txt to
> see when a root item is a snapshot and not a subvolume.
>
A small tip for the next one :

To understand how and where some function is called (here 
btrfs_list_subvols_print), grep in in "cmds" subdirectory (here 
logically subvolume.c).

