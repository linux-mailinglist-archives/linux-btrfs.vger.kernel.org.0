Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643E4A99F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiBDNaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 4 Feb 2022 08:30:07 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:33711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiBDNaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 08:30:06 -0500
Received: from [192.168.177.41] ([94.31.101.241]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MOiU5-1mr2BP2ieF-00QG94 for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022
 14:30:04 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx errors 1, no
 inode item
Date:   Fri, 04 Feb 2022 13:30:03 +0000
Message-Id: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.2.1659.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:CrU+31YcDdROVpgHGy1yuJJ8pIZ2tlS4up3SGLle2N/zAonUpBb
 T+GORVpm2MllMB98LJ7pzELdfkYCSZUk37LRvB+r7LgWvbdAkrjbxz1IX8HfKib9JPUPZqm
 45bwI8UkL1UellWYnntq8yuMffxWc3h8ulDTnZhPlfDrhnyAU7MnzksOn61iuWQWGFu3SGp
 6LJa08XIw/u/oSCY82maA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rgK9f6PJOU=:TOpGPAxPJdPwUOcP67Pgwu
 SRpvfeSPvYByV9xzkw+c9Te03HSnb9LduO5i7Fhxqk3q6xeDwwwsLzj+A8qlrfDbsBTVThYHE
 LXNdOwo+cVvK6bfF3Zjl8RrHk9e8wsSrZlDdnmvUQ3JZkLRia5+bL6n+4YRaEH5aRWZluChJG
 gt1kHkvRrwP1A63hEdsnt7XLxX7nxQfXJnoKRtVFDbMnVdKsCMtMvDMjwrZfjKIMu649oOzTU
 hBrdTNs320sKYW+rsDogedX0ohPhCX0UciQAjO2bJIU0x0FV1MyfuK+jqFarhKi6C9rDDFgIY
 Q71olhx/H1KDiWTwHEvAa93H/jQHbLrVwH9EQ1rgzkKid5XCP5VwUZGUdJ5Vq7JjchNR0fN8G
 bIdbaig7ngxmsG5qs3bEyuuoPeE4ODvoAvYe8W12TDpmawv3ZjfZNc+celp1dLGRY0K6YK6NV
 MlG+ViAWh5Vt5HC3qB7IkVwYdXxiBwDBJM3UnLOLU3daJQX/WuEpSBXqwBEl3NtqAnsQ71olj
 X/7WCTavM/hexwYQ0ENLfkDtz5ZQTLN/oIr6m/XntCrsxR4CawZvO+ETurlOVMyIbWNODU+Er
 eT23Fi2Vb3edcY9G7lQnVYYCdL1dyR5Z+Ku/vZdJF4oT5Q+4PjzQGM9XzG4DZxWIi1+wni2a/
 fjpOFaLddo8WIFqZE6Pae+Mv4xQplyUNuQQHEqSnFZUVb7YenGzIlEeEsx6skY+wEd8M=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I found some files for which ls -l gave me odd output (??????) instead 
of mtime etc.

So I ran btrfs scrub without errors and then btrfs check with these 
errors:
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 5 inode 79886 errors 200, dir isize wrong
root 5 inode 59544488 errors 1, no inode item
         unresolved ref dir 79886 index 199 namelen 11 name global.stat 
filetype 1 errors 5, no dir item, no inode ref
root 5 inode 59544493 errors 1, no inode item
         unresolved ref dir 79886 index 200 namelen 10 name global.tmp 
filetype 1 errors 5, no dir item, no inode ref
         unresolved ref dir 79886 index 203 namelen 11 name global.stat 
filetype 1 errors 5, no dir item, no inode ref
root 5 inode 59544494 errors 1, no inode item
         unresolved ref dir 79886 index 202 namelen 9 name db_0.stat 
filetype 1 errors 5, no dir item, no inode ref
root 5 inode 59544495 errors 1, no inode item
         unresolved ref dir 79886 index 204 namelen 10 name global.tmp 
filetype 1 errors 5, no dir item, no inode ref
ERROR: errors found in fs roots
found 62813446144 bytes used, error(s) found
total csum bytes: 43669376
total tree bytes: 665501696
total fs tree bytes: 329498624
total extent tree bytes: 240975872
btree space waste bytes: 119919077
file data blocks allocated: 4766364479488
  referenced 60131446784

How do I fix these?
I am runing linux 5.13.9 (about to update to 5.16.5).

Best regards,
Hendrik

