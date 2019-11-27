Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1EC10A976
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 05:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK0EoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 23:44:12 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48370 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0EoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 23:44:10 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 58CF54F8A73;
        Tue, 26 Nov 2019 23:37:44 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1iZp5E-0003P5-5h; Tue, 26 Nov 2019 23:37:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: add support for LOGICAL_INO_V2 features in logical-resolve
Date:   Tue, 26 Nov 2019 22:55:03 -0500
Message-Id: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set adds support for LOGICAL_INO_V2 features:

        - bigger buffer size (16M instead of 64K, default also increased to 64K)

        - IGNORE_OFFSETS flag to look up references by extent instead of block

If the V2 options are used, it calls the V2 ioctl; otherwise, it calls
the V1 ioctl for old kernel compatibility.


