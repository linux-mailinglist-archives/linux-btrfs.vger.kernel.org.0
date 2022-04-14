Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DF5014AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiDNON4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbiDNNnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 09:43:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A128E29
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 06:39:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBF9621618;
        Thu, 14 Apr 2022 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649943575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsuNXiOXCHMfBDFMimGlmdtKWuuweVAqIO5LBSQ6ArY=;
        b=hc79GOiVctS5ChqGunLyPbXTmM2bXXzGI2Ltk0z+qPFEbTDkgNy9CCcetal0hOEItGyjVa
        ad4jxRP8GUmnDzmZ/fDbE3GViregD0l2dE7Tg7uyJ2A3fSOPvgSSoZcL134D5kAuMTdxHB
        aLur+pcY+bsUA4Fdp5k8yjDHux+kkKI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF879132C0;
        Thu, 14 Apr 2022 13:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J4s7KxckWGI3SgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Apr 2022 13:39:35 +0000
Message-ID: <605b45a5-cb80-a32f-0744-8441e46fb3a9@suse.com>
Date:   Thu, 14 Apr 2022 16:39:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: what mens gen and ogen in btrfs sub list / ?
Content-Language: en-US
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
References: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.03.22 г. 14:38 ч., Lentes, Bernd wrote:
> 
> Hi,
> 
> i'd like to write a script in which, beneath other stuff, the oldest snapshot(s) are deleted.
> So i'm looking for a way to sort the list of the snapshots by date.
> I read the manpage and stumbled across gen and ogen of snapshots.
> But what does that mean and how can the values be interpreted ?
> Or is there another way to list the snapshots by e.g. creation date ?
> 
> OS: Ubuntu 20.04
> btrfs-progs: 5.4.1-2
> 
> root@nc-mcd:~/skripte# btrfs sub list -tcg /
> ID      gen     cgen    top level       path
> --      ---     ----    ---------       ----
> 273     1060462 170590  5               snapshots/pre_upgrade_27112020
> 279     1060464 1006204 5               snapshots/root-19102021
> 
> 
> Thanks.




So 'gen' is the current transid of the volume, that is the last 
transaction into which  something changed i.e a file was 
created/modified/deleted etc.

cgen OTOH is the transaction when the given subvolume was created.
