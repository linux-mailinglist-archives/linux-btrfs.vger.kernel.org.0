Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112B7B6867
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjJCL6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjJCL6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 07:58:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58941AC;
        Tue,  3 Oct 2023 04:57:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E22C433C8;
        Tue,  3 Oct 2023 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696334278;
        bh=+kQpSyNCJTamLhUA2rq85dPjLBF5LvmB0H2H1fNYggs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ghf8+Jl0qhpptNGJ0rKeGjQnFKti6MBo8DNFDOwMht76jb4B5kcIWy4eQK6nuignO
         f8qKad5Zy0ZkH3FWbiVntB1VOU0ROLSiKZhCbLxC4VMj9Kes8GroSbMaBejP/GRW/G
         6rVN7S3+04oVvHFFrPy8GkD9CWat/G+VYKvPtjq2tZxs8E0RXLH5/+YX8HqdnJYhl/
         Rt8OlqKF3acIfw2RS8YlzKWp0jy3nG+LOOQoLHm7knAKxhBDe7fJFcCtsUxXIQk8+A
         oLJXOg8SdTDgRk4c7FKxO2zsjPEXBJUw2Gacx84at2ZeEtkCP1WW/5FPpfnC2Z1B9C
         G0NqOCWBiD9wg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] fstests: make some tests that use fsstress easier to debug
Date:   Tue,  3 Oct 2023 12:57:43 +0100
Message-Id: <cover.1696333874.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some tests that use fsstress are harder to debug than necessary because they
redirect fsstress' stdout to /dev/null instead of $seqres.full. This means we
have no way of knowing the seed used by fsstress which often helps to trigger
a bug/failure. More details on the change logs of each patch.

Filipe Manana (2):
  fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null
  btrfs/192: use append operator to output log replay results to $seqres.full

 tests/btrfs/028   | 2 +-
 tests/btrfs/049   | 2 +-
 tests/btrfs/060   | 2 +-
 tests/btrfs/061   | 2 +-
 tests/btrfs/062   | 2 +-
 tests/btrfs/063   | 2 +-
 tests/btrfs/064   | 2 +-
 tests/btrfs/065   | 2 +-
 tests/btrfs/066   | 2 +-
 tests/btrfs/067   | 2 +-
 tests/btrfs/068   | 2 +-
 tests/btrfs/069   | 2 +-
 tests/btrfs/070   | 2 +-
 tests/btrfs/071   | 2 +-
 tests/btrfs/072   | 2 +-
 tests/btrfs/073   | 2 +-
 tests/btrfs/074   | 2 +-
 tests/btrfs/136   | 2 +-
 tests/btrfs/192   | 4 ++--
 tests/btrfs/232   | 2 +-
 tests/btrfs/261   | 2 +-
 tests/btrfs/286   | 2 +-
 tests/ext4/057    | 2 +-
 tests/ext4/307    | 2 +-
 tests/generic/068 | 2 +-
 tests/generic/269 | 2 +-
 tests/generic/409 | 2 +-
 tests/generic/410 | 2 +-
 tests/generic/411 | 2 +-
 tests/generic/589 | 2 +-
 tests/xfs/051     | 2 +-
 tests/xfs/057     | 2 +-
 tests/xfs/297     | 2 +-
 tests/xfs/305     | 2 +-
 tests/xfs/538     | 2 +-
 35 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.40.1

