Return-Path: <linux-btrfs+bounces-11565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF044A3BD3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E14189C260
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD51DF25E;
	Wed, 19 Feb 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmu+Vdla"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B691B85CC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965411; cv=none; b=oVEWXhlz0g2SywPfDzFzfiFHScG35dcDPGG9sO1DYV5VD3NtAvMv7g28vEMjZbEvveRYjuVi7GzzoHZhiZyBIbQ//dkVj9jfNjG/LUklN4OC7nu5s8EZzddEf2M4csAKdYO08vLt744mGv80ql83zme6qmj3XPGIVjsqqKeZb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965411; c=relaxed/simple;
	bh=xkDNnegrFzuaKNJzU/iKev7RDXlQcgpQz6SBa1QTr4c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lX98RzTIWQpIfCYUs4oDDG6J5qjDibTMnR2TnpbPNcC9QobuuHag1x7at6mrrBIeZdnAsAErNLddeyp8KaFnRPfEzWTzt0N1UrpV25VPw1z4fXtsjjInZG8dGrbhV5A0ZM+xwuaCd99CsI9Ar6hTDyilMV7jQplUjVqUZ9J8ReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmu+Vdla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1AEC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965410;
	bh=xkDNnegrFzuaKNJzU/iKev7RDXlQcgpQz6SBa1QTr4c=;
	h=From:To:Subject:Date:From;
	b=Fmu+VdlairKWVMcErpFEh/539zzDQkoK69XM1YB9AJKelikkjEoUT2bnNFArh/gAw
	 KupgBwpWBzu11BNiaB/pfQTUopxP9O9ufGS6BmBZNGaLDSKvMUQNBHIBRQkFH+hnQK
	 x0SSaAf8E//k7FXqF3Vi4nyFan/++50SGX3hkkPy33HWqE1QMF8QhUGu7K4qU33NcQ
	 W00sGpIJ9lBw6F41c5+ORStJot8MIuT2CZGmDbhzGv/RTbGS+SuxrkuVwpdom1Dot8
	 dNFOd6umUtm51tIh7l2T9KH73xRSW7cVCCDWFoMwlS/+eMBZrnrWrlFx8bDWI8rBpr
	 C268NxgJhLDdA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/26] btrfs: avoid repeated path computations and allocations for send
Date: Wed, 19 Feb 2025 11:43:00 +0000
Message-Id: <cover.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This eleminates repeated path allocations and computations for send when
processing the current inode. The bulk of this is done in patches 24/26
and 25/26, while the remainder are cleanups and simplifications, some of
them to simplify the actual work related to avoiding the repeated path
allocations and computations.

A test, and its result, is described in the change log of patch 25/26.

Filipe Manana (26):
  btrfs: send: remove duplicated logic from fs_path_reset()
  btrfs: send: make fs_path_len() inline and constify its argument
  btrfs: send: always use fs_path_len() to determine a path's length
  btrfs: send: simplify return logic from fs_path_prepare_for_add()
  btrfs: send: simplify return logic from fs_path_add()
  btrfs: send: implement fs_path_add_path() using fs_path_add()
  btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
  btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
  btrfs: send: simplify return logic from __get_cur_name_and_parent()
  btrfs: send: simplify return logic from is_inode_existent()
  btrfs: send: simplify return logic from get_cur_inode_state()
  btrfs: send: factor out common logic when sending xattrs
  btrfs: send: only use booleans variables at process_recorded_refs()
  btrfs: send: add and use helper to rename current inode when processing refs
  btrfs: send: simplify return logic from send_remove_xattr()
  btrfs: send: simplify return logic from record_new_ref_if_needed()
  btrfs: send: simplify return logic from record_deleted_ref_if_needed()
  btrfs: send: simplify return logic from record_new_ref()
  btrfs: send: simplify return logic from record_deleted_ref()
  btrfs: send: simplify return logic from record_changed_ref()
  btrfs: send: remove unnecessary return variable from process_new_xattr()
  btrfs: send: simplify return logic from process_changed_xattr()
  btrfs: send: simplify return logic from send_verity()
  btrfs: send: keep the current inode's path cached
  btrfs: send: avoid path allocation for the current inode when issuing commands
  btrfs: send: simplify return logic from send_set_xattr()

 fs/btrfs/send.c | 485 +++++++++++++++++++++++-------------------------
 1 file changed, 232 insertions(+), 253 deletions(-)

-- 
2.45.2


