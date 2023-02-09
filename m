Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34E690E1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBIQOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIQOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 11:14:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3025BBF;
        Thu,  9 Feb 2023 08:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 616C6B821E8;
        Thu,  9 Feb 2023 16:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C12C433D2;
        Thu,  9 Feb 2023 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675959237;
        bh=1GA+TyEbestszAl8+7DozaEDq4NmEljfALXCNzsQb6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBYDwIpbRQ5K2cIY6yBMZomurpCc+eh9LCCE69qlue8v00igrxXZ7w7bg22176eQ5
         Wp3nYFjQdj14snQzmf70yFbFT1Ug/8M3H8iPhmk0GNbxvxoe66DP9+UfeMBiMU1Ip7
         p3o4pZDOJHb8YZFrc2/lq5P65tvBTFYXuldf43vWe6H2C90QMsriJ3bHgqOqb4zm8V
         PRpTS7dRSKpe5OnOvQxZKmHZXxpYZMCglj526VoVa+SL24fcOK9ZfPBkM19UPLDzz6
         s4RKQbWvK8prSYliriCqs2cq1Mqvzj6QOb6p4Si1WI4wFZYvtJvzBuLXp3q5uKUque
         b46VdLrHCOeWg==
Date:   Thu, 9 Feb 2023 08:13:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: run more tests in the auto group
Message-ID: <Y+UbxH+VLmHOSMNh@magnolia>
References: <20230209051355.358942-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 09, 2023 at 06:13:48AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a more tests to the auto and quick groups so that they
> are run as part of the usual regressions tests.

For patches 4-7,

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

