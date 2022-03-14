Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5784D79EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 05:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiCNEij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 00:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiCNEih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 00:38:37 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36C9838D8D;
        Sun, 13 Mar 2022 21:37:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6F39510E400D;
        Mon, 14 Mar 2022 15:37:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nTcSS-005EJ7-SD; Mon, 14 Mar 2022 15:37:24 +1100
Date:   Mon, 14 Mar 2022 15:37:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: delete the cross-vfsmount reflink tests
Message-ID: <20220314043724.GP661808@dread.disaster.area>
References: <cover.1647015560.git.josef@toxicpanda.com>
 <3c6801168d8f7fd1bd2ae47f9a823d9c28a35422.1647015560.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6801168d8f7fd1bd2ae47f9a823d9c28a35422.1647015560.git.josef@toxicpanda.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=622ec686
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=maIFttP_AAAA:8 a=7-415B0cAAAA:8
        a=qc-lFo39poi8ebtawUsA:9 a=CjuIK1q_8ugA:10 a=qR24C9TJY6iBuJVj_x8Y:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 11:20:53AM -0500, Josef Bacik wrote:
> Cross vfsmount reflink's are now allowed, the patch is in linux-next and
> will go to linus soon.  Remove these tests so nobody freaks out when
> they start failing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Shouldn't these tests be converted to test that cross-vfsmount
reflinks now actually work?

i.e. it's all well and good to remove tests of behaviour we no
longer enforce, but to then not test the new behaviour we allow is
actually working properly....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
