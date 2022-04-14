Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8982500A0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiDNJmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbiDNJmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 05:42:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D04657A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 02:39:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99E4621618;
        Thu, 14 Apr 2022 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649929177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSD95w+e2Eu/B694Giv/t+XmTQOpLrqRK5nDNVty+7A=;
        b=CPgbqSTqs1+ar9rSRC/wAvAYccjL8XuvIqjI0p7Lo6X+ZMnd2iDIV2QabvXYZ3Kg7UFD0v
        aVmh5Rk3cXhH8prfVNbWKOQMQLCxvDNFNJ4bvBzKvmCrtVRFs3gVZ9csNjojGPlNArpPVi
        gXBBYhC0nedWxRrYewco477EFJR1EsU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BDCA13A86;
        Thu, 14 Apr 2022 09:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7XGuHNnrV2JGaAAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 14 Apr 2022 09:39:37 +0000
Message-ID: <588228bd-4838-b4c1-507b-08d445cdc85b@suse.com>
Date:   Thu, 14 Apr 2022 11:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220412123546.30478-1-gniebler@suse.com>
 <20220413141401.GJ15609@twin.jikos.cz>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220413141401.GJ15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 13.04.22 um 16:14 schrieb David Sterba:
> On Tue, Apr 12, 2022 at 02:35:46PM +0200, Gabriel Niebler wrote:
>> [...]
>> ---
>>
>> Notes:
>>      XArrays offer a somewhat nicer API than radix trees and were implemented
>>      specifically to replace the latter. They utilize the exact same underlying
>>      data structure, but their API is notionally easier to use, as it provides
>>      array semantics to the user of radix trees. The higher level API also
>>      takes care of locking, adding even more ease of use.
>>      
>>      The btrfs code uses radix trees in several places. This patch only
>>      converts the `delayed_nodes_tree` member of the btrfs_root struct.
> 
> You've put this under the --- marker which means this is not supposed to
> be in the changelog (as we do for various patch revision commments) [...]

I did, because I thought that my general waffling about XArrays is not 
something we need to have in the kernel changelog forerver, however...

> [...] but
> then there would be basically no useful changelog left. [...]

That's a good point. I kind of forgot that a good commit message is 
supposed to say *why* something was done and not just *what* was done, 
as that's obvious from the diff.

> [...] That the
> conversion is done is clear, maybe there are some useful notes or
> comments what changed and how, eg. the locking.

I'll try to come up with something more satisfying, yet not too verbose.
