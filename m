Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6AC1B64
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfI3GW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 02:22:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfI3GW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 02:22:28 -0400
Received: from jupiter.fkoop.de ([79.231.199.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVJZv-1iggx32o2p-00SOX8 for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019
 08:22:26 +0200
Message-ID: <e29ff3cc4a2cfac8b24d694eecee594c129b2115.camel@fkoop.de>
Subject: Bad tree block - data rescue possible?
From:   Felix Koop <fdp@fkoop.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Mon, 30 Sep 2019 08:22:26 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ORlgRGjop23l7Y+nhpkYRWnOT+n+tbOG2IC+311ziP4/oY4y4FK
 oZ51ZLGKZx8yif71ma9/Y+lUlTaEd3e5pkhfnBpuTsu3E4o5q69HrdBYhoXAFD/JsETC+wM
 ZAUABw8i1nR1DVhfy5yiXj97fsP5SSlQlQ4rdn+M1ngeN8DNKnwJgI0+dWmC9kjLGnFVHA6
 SHXNtL/EjYuspPevAQ8tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6I4+nAXbZuQ=:2WLZfW6m2u9PeR4KXSkfaD
 8tPO/jNhkcp7EzAk/bBrYIj2oZpHjuovB/QMzd2nf4Iu0K2PZU2utr05koQuR9YAbQdmlm8mc
 uGRi4BljU1f4Uhccq7JiQJvT0qrY1YKG2uTzFQul44YhFDBnPn9qwVHxlDD+hJPQGQYiJO9fd
 ij3DDxBt+8fEdIeah1XfUxdZRCCRpBcRPAMs1hMk6k09lxBrKpdAytGLa1nWfdvKESq0VT0kF
 FtVbxZzN+7R41GHo2sHk7Rsu+auFZ9MTiKNrOQMeDsj0/AZd2VRDemEHkro1wJOXEqJj6lqcA
 w3UeOFfrr+LaqPYAI6OnZOkN4BCHuxDb3tDEdZ9G9Tyf8q0TdR1c/kkApTEcTg85QCSTZhU/Y
 HE9JYsw5x3aIRM/ufBzy3QgZu/77pqf7XcLyN5HFilcq3FhONLkXNYsp50EjUD7pdQy/kOjWr
 uoWJO3Ie77qlPPLrtdYdyqdMpy7+Epx3pFU7FgOZWUkIviEIS2lULd0FT2EEF+GQ+kf1PdMrc
 yVmYRNMAoWOlcQPNhqX3ngB5gFsD2v26bMXKchzG53JlzQ92cWJ2bx4R1p4+0V4UHxpVUjAa6
 ygRLqguU+tXkd5oeBxUiX0K9+lG0o/XUnDdP/lZR2ai/k9D12Btij1Im4rWENm9it1wtLk+B0
 TKJO1lMOunJFvTE7xnaJKNhzv2dBtJNGUnc4tuzV2yNghGj8nBy9C/cahNeyglsCcF7bHGFCk
 dGhESPj6gZz/ZqSFpEqMacASrFalY5TGf+rZ9hiRy9EIEeVRKwtdqIVb0ICFfsopndI0NxJSL
 B4jEh5bZkBrhJtFZX19XSLJJuYWb9UwGvQdfdfVfU+eyAPY0HICkvP8JZZnfNgp0D13D/+Vn7
 htxwUfxYzi3IFPfgnnPg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

please help. I have a btrfs filesystem that does not mount any more.
This is the error I get:

root@tuxedo:~# mount -t btrfs /dev/md/8 /archive/
mount: /archive: wrong fs type, bad option, bad superblock on /dev/md8,
missing codepage or helper program, or other error.

root@tuxedo:~# btrfs check --readonly /dev/md/8
Opening filesystem to check...
checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
checksum verify failed on 525573472256 found 72A4DA2D wanted 5756BAAD
checksum verify failed on 525573472256 found 34F97C00 wanted 15AEE1E6
bad tree block 525573472256, bytenr mismatch, want=525573472256,
have=6438209987097185951
ERROR: cannot open file system


relevant dmesg:

[  288.589999] BTRFS info (device md8): disk space caching is enabled
[  288.590004] BTRFS info (device md8): has skinny extents
[  291.596699] BTRFS error (device md8): bad tree block start
6438209987097185951 525573472256
[  291.608786] BTRFS error (device md8): bad tree block start
2211084770032297782 525573472256
[  291.608844] BTRFS error (device md8): failed to read block groups:
-5
[  291.660214] BTRFS error (device md8): open_ctree failed


I am currently running kernel 4.15, but I tried also a 5.0 kernel and could not mount the data either. btrfs is version 4.20.2 on ubuntu disco.


-- 
Mit freundlichen Grüßen

Felix Koop
fkoop@fkoop.de

