Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D350180D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiDNQAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 12:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352739AbiDNPRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:42 -0400
X-Greylist: delayed 1544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 08:03:18 PDT
Received: from twin.jikos.cz (twin.jikos.cz [91.219.245.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD6395A07;
        Thu, 14 Apr 2022 08:03:16 -0700 (PDT)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 23EEbTZI002298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 Apr 2022 16:37:30 +0200
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 23EEbT8S002297;
        Thu, 14 Apr 2022 16:37:29 +0200
Date:   Thu, 14 Apr 2022 16:37:29 +0200
From:   David Sterba <dave@jikos.cz>
To:     dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc3
Message-ID: <20220414143729.GP3658@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1649705056.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649705056.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm sending this from a different mail address after 2 days of no reply
and no merge of the btrfs updates (message body deleted in case it
triggers the spam filter). The mail is in lore archives at
https://lore.kernel.org/all/cover.1649705056.git.dsterba@suse.com/
