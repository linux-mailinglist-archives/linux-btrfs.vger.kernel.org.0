Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CC62A147
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiKOSXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKOSXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:23:32 -0500
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5957B5C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:23:23 -0800 (PST)
Received: from [192.168.1.27] ([84.220.130.49])
        by smtp-17.iol.local with ESMTPA
        id v0afokrIv5RyRv0afoYjif; Tue, 15 Nov 2022 19:23:21 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1668536601; bh=qVBxtu1uSHfjfjr+bxkGheA8ZSmm3e3ssoEk4b+gPMY=;
        h=From;
        b=wxjwCvFJsmQf3/8PZs/7cdMkWlvZ8owPsSRm+WyYa18/IkSel8JarS8gG3jo9matJ
         dK1rGLZNxANmHKRR5h3I0OotxDQjwfKtwUGYwGewX8oSpAGRMDC4l8Ods/IDjgzkt7
         xNd6pR5AC8EnnHdWCb1EbUhumU8jX9U8QhSFvUr6g8inMA7YQtsu7TknkMdNGz8n2T
         nvh6tlJSKZGG50txETmCbOkPCi7ys2jArMjtAT3HcaDc/KVh5G4sri4pJUpQ9z5kMO
         sXBgKgQTw1j3jbhMKNDobQwlKVh6WI5G+JG48SAAzQB/S9xAB/tksSNS4Z6ou/fwnV
         5JfGjO1eAEAVA==
X-CNFS-Analysis: v=2.4 cv=JtI0EO0C c=1 sm=1 tr=0 ts=6373d919 cx=a_exe
 a=SdbLdwgxGF07xCE66nLfvA==:117 a=SdbLdwgxGF07xCE66nLfvA==:17
 a=IkcTkHD0fZMA:10 a=UiJr9HJGYcx6SF-fYyYA:9 a=QEXdDO2ut3YA:10
Message-ID: <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
Date:   Tue, 15 Nov 2022 19:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: kreijack@inwind.it
Subject: Re: property designating root subvolumes
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEqFOXs7IHRrOoeX94z4Cl/hWf5Erk3HO30KTal0GV6y9mUf2Lz5PhDX3uk9UaOsolW3ETdrN7YaYz1KRl+MHkaStKTgW/tfJ/KC7wVfmZOvDVk6epCW
 mp/H3OZEOK2dM43pndAm7HFOCJn/E/NymxEHzwSly47pq3Qm+ToJQl+Ma/1J2pXohwHBcp/Ki5BljG7luOTlYm6Z6PwlcUBiIo7j82TyzQnMntSbsM5Ovfe1
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/11/2022 00.23, Eric Levy wrote:
> The file system allows one subvolume per partition to be designated as the default, and no more than one would be sensible. Generally, for partitions organized with a base file hierarchy constituted of multiple subvolumes, the one representing the root mount would be designated as the default. Although this association is not required, it is a reasonable assumption, enough so that some tools depend on it for certain features. For example, the rEFInd bootloader scans a BTRFS file system for a Linux-based OS by attempting to identify a root file hierarchy on the default subvolume. However, in such usage, the constraint of one subvolume designated per partition is limiting. In principle, a bootloader might support multiple operating systems installed on the same partition, as long as each root partition may be separately indicated. To support such usage, it might be helpful if a property, separate from the designation of a default subvolume, was supported. As a property, it 
> would be allowed to be assigned arbitrarily to any number of subvolumes.


I don't know rEFInd very well, but I don't think that it is job of the bootloader to do the automatic OS discovery.

If you want to perform an OS discovery, at first it would be enough to check the presence of "/bin/init" (or /init or ...) for linux and the equivalent for Windows and OS-X.
But this will not give the information like:
	- os name
	- initrd
	- the linux boot parameter...

Some (most) setup have different boot entries for the same filesystem (e.g. the standard one, and the emergency one).

I prefer the other way that it is used in the linux world: it is responsibility of the os to inform the bootloader about its existence.
Look at the BLS specification (even not so widespread adopted).




> 
> Presently, rEFInd supports multiple operating systems on different subvolumes of the same partition only by static configuration. Such a constraint is particularly cumbersome because any operation for installing the bootloader utilizes configuration only on the active operating system.
> 
> In principle, the broader concept might be extended further, adding even more properties, for supporting yet further use cases. As one example, a subvolume might be selected as containing configuration information applicable to the bootloader, regardless of the active operating system. Such a feature would facilitate synchronization of bootloader settings for installation tools across all operating systems on a partition. Yet, even the single new property would support cleaner semantics for greater flexibility of usage.
> 
> Note that for such a feature to work properly, the file system would need to enforce that the property not be inherited by child volumes, that is, snapshots derived from a subvolume with the property enabled. Furthermore, some thought must be given to the case of the user enabling the property for a subvolume having an ancestor with the property already enabled. In such a case, it most likely is desired that the property would be disabled for the ancestor.
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

