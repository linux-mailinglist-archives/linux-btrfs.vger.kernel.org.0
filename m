Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105287ADDC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 19:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjIYRUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 13:20:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698010D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 10:19:57 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d84f18e908aso7506057276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=switchboard.app; s=google; t=1695662396; x=1696267196; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QjnkijhwSsCPk2h/jTsDEXNmxYLy2qvlppMBV2u9MeU=;
        b=b7iw9EeyDDwncxt3sxvafLZqOxHNJCsdJXDi0CW3hO31irs4Dr6NzkCMA0Rd18jfMC
         NFoTM93ANp81Nd0qixHzmm3KobvfLzPY7ZFcZcXxS7vP6+7APqoLcwRYLjv2qkY7aosT
         75NMj7OzKCcwvRQ4e0/pXt9wovRHjdl5mslmKIcHDbS/6VPFAfoXD/Eru4/+xdVlzYfo
         FEy8UWz1xm7ucHCWYoUujTIB8jiq2k0NLHSwJC+9LFzxrM2jp0RkRFD1vhled1G5bf1j
         fmt5tHI+9Md+H563QCIxsQaFu97xUqqruOjX5jPdUenVUW1QNoPz0OT5nWA3z6/U9B+0
         gOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662396; x=1696267196;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjnkijhwSsCPk2h/jTsDEXNmxYLy2qvlppMBV2u9MeU=;
        b=ohge3qhRtZ/ceY175VPd32/wlD+z/f1AzZxw+VkKAzySC2brWDpfnumIrI0Zdnw8qH
         Bi+utZ+oRisbDSfv+xfflqW/et04lpnDiTAR1s66BiBK3k/r+6FwoUTtkkTKiZSF0PSR
         FTCHXeka6fx3mHJZ+pre+JONRqZiM8tcCXQC7yrRMwpwcHHPimQ9XSxj3NBDl5fmvaQx
         xw1XP3undlm6pOImnllNt/LFEQ3KxvjHXgwcagopfXTcoDHfg3Jkthnqy8kUpVVfMlUs
         E1jcA6cwpSHxDfX5zTBRizfFE/OGD1Cj+sOuQ5ci9qBftbwQKvr6TUJ2Jpo3gd28ad2Y
         /gBg==
X-Gm-Message-State: AOJu0YxCLvCJ2fDOmZnqJewaqPYItiz8Yu4x3GmJJHx1DdcPXlmb+iEI
        h+3+GQarj2gPzaajote8T+spopeIVq+mchKEP2X0+VRymhdJOZQY5W4UAA==
X-Google-Smtp-Source: AGHT+IG/vAi2PXQdeaZjtYy/nFRCQzgfPqIXHkCKd81Tfu8y75ztSVJf/I5bn+/Ehxvem3MUv8nO2uj1K12MGJuMedk=
X-Received: by 2002:a5b:181:0:b0:d81:69f7:1731 with SMTP id
 r1-20020a5b0181000000b00d8169f71731mr6521627ybl.18.1695662395176; Mon, 25 Sep
 2023 10:19:55 -0700 (PDT)
MIME-Version: 1.0
From:   Arno Renevier <arno@switchboard.app>
Date:   Mon, 25 Sep 2023 10:19:44 -0700
Message-ID: <CAFmLMRMYzSfmJvp0gccr0siT6jX8Nv5Xt9jVKfiUeXhpy3WRqw@mail.gmail.com>
Subject: SIGBUS with mapped file on full device
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b96b850606322ad7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000b96b850606322ad7
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that when storing user data on btrfs, chromium is systematically
crashing with a SIGBUS signal when the disk is full. It does not happen
with ext4.

This seems to happen because after failing to write to a file
(unsuccessfully), chromium tries to write into a mapped file. That mapped
file has been previously opened, and fallocated, and some data has been
written into it to make sure the extent of the file is realized.

I will attach the reproduce the crash. It creates a file, fills it with
data, and opens memory maps that file. Then, it creates another file, and
tries to write into it until the disk runs  out of space. And then, it
tries to write into the mapped file. It always results in a SIBGUS crash
for me. There is no such crash with ext4.

Is it a bug in btrfs, or is the testcase (and chromium) doing
something improper? (and if so, what should be done instead?)



bug I opened against chromium:
https://bugs.chromium.org/p/chromium/issues/detail?id=1484662
chromium code executed before a file in mmaped:
https://source.chromium.org/chromium/chromium/src/+/main:base/files/file_util_posix.cc;l=967?q=file_util%20posix&ss=chromium

instructions how to run the testcase:

$ truncate block.img -s 200M
$ mkfs.btrfs -f block.img
$ mkdir -p mount_point
$ sudo mount -o loop block.img mount_point
$ sudo chown $USER:$USER -R mount_point
$ clang++ crash.cpp -o crash && rm -f mount_point/map.data
mount_point/file.data && ./crash mount_point

...


$ uname -a
Linux archlinux 6.5.3-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 13 Sep 2023
08:37:40 +0000 x86_64 GNU/Linux
$ btrfs --version
btrfs-progs v6.5.1
$ btrfs fi show

$ btrfs fi df mount_point
Data, single: total=8.00MiB, used=0.00B
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=32.00MiB, used=128.00KiB
GlobalReserve, single: total=5.50MiB, used=0.00B

--000000000000b96b850606322ad7
Content-Type: text/x-c++src; charset="US-ASCII"; name="crash.cpp"
Content-Disposition: attachment; filename="crash.cpp"
Content-Transfer-Encoding: base64
Content-ID: <f_lmz5lo980>
X-Attachment-Id: f_lmz5lo980

I2luY2x1ZGUgPHN0cmluZz4KI2luY2x1ZGUgPGNzdHJpbmc+CgojaW5jbHVkZSA8c3lzL3N0YXQu
aD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGZj
bnRsLmg+Cgpib29sIGlzX2RpcmVjdG9yeShjb25zdCBjaGFyICpwYXRoKSB7CiAgc3RydWN0IHN0
YXQgc3Q7CiAgaWYgKHN0YXQocGF0aCwgJnN0KSA9PSAtMSkgewogICAgcHJpbnRmKCJFcnJvcjog
JXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICByZXR1cm4gZmFsc2U7CiAgfQogIHJldHVybiBT
X0lTRElSKHN0LnN0X21vZGUpOwp9Cgpib29sIGFwcGVuZChpbnQgZmQsIHNpemVfdCBzaXplKSB7
CiAgdm9pZCogYnVmZmVyID0gbWFsbG9jKHNpemUpOwogIG1lbXNldChidWZmZXIsIDAsIHNpemUp
OwogIGlmICh3cml0ZShmZCwgYnVmZmVyLCBzaXplKSA8PSAwKSB7CiAgICAgIHByaW50ZigiRXJy
b3IgaW4gYXBwZW5kOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAgZnJlZShidWZmZXIp
OwogICAgICByZXR1cm4gMDsKICB9CiAgZnJlZShidWZmZXIpOwogIHJldHVybiAxOwp9CgppbnQg
ZmRfb3Blbl9maWxlX2Zvcl9jcmVhdGUoY29uc3QgY2hhciAqcGF0aCkgewogIGludCBmZCA9IG9w
ZW4ocGF0aCwgT19SRFdSIHwgT19DUkVBVCB8IE9fQVBQRU5ELCBTX0lSVVNSIHwgU19JV1VTUik7
CiAgaWYgKGZkIDwgMCkgewogICAgICBwcmludGYoIkVycm9yIGluIGZpbGUgb3BlbmluZzogJXNc
biIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgIHJldHVybiAxOwogIH0KICByZXR1cm4gZmQ7Cn0K
CmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgewogIGlmIChhcmdjIDwgMikgewogICAg
cHJpbnRmKCJVc2FnZTogJXMgPGRpcmVjdG9yeT5cbiIsIGFyZ3ZbMF0pOwogICAgcmV0dXJuIDE7
CiAgfQogIGNvbnN0IGNoYXIgKmRpcmVjdG9yeSA9IGFyZ3ZbMV07CiAgaWYgKCFpc19kaXJlY3Rv
cnkoZGlyZWN0b3J5KSkgewogICAgcHJpbnRmKCJFcnJvcjogJXMgaXMgbm90IGEgZGlyZWN0b3J5
XG4iLCBkaXJlY3RvcnkpOwogICAgcmV0dXJuIDE7CiAgfQoKICBjb25zdCBzdGQ6OnN0cmluZyBt
YXBwZWRfZmlsZV9wYXRoID0gc3RkOjpzdHJpbmcoZGlyZWN0b3J5KSArICIvbWFwLmRhdGEiOwoK
ICBzaXplX3QgbW1hcF9zaXplID0gMTAyNCAqIDEwMjQgKiAxMDA7CiAgLy8gY3JlYXRlIGEgbGFy
Z2UgZmlsZSBmaWxsZWQgd2l0aCAwCiAgewogICAgaW50IGZkID0gZmRfb3Blbl9maWxlX2Zvcl9j
cmVhdGUobWFwcGVkX2ZpbGVfcGF0aC5jX3N0cigpKTsKICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
KG1tYXBfc2l6ZSAvIDEwMjQpOyBpKyspIHsKICAgICAgaWYgKCFhcHBlbmQoZmQsIDEwMjQpKSB7
CiAgICAgICAgYnJlYWs7CiAgICAgIH0KICAgIH0KICAgIGNsb3NlKGZkKTsKICB9CgogIC8vIG1t
YXAgdGhhdCBmaWxlCiAgaW50IG1hcHBlZF9mZCA9IG9wZW4obWFwcGVkX2ZpbGVfcGF0aC5jX3N0
cigpLCBPX1JEV1IgfCBPX0NSRUFUIHwgT19BUFBFTkQsIFNfSVJVU1IgfCBTX0lXVVNSKTsKICBp
ZiAobWFwcGVkX2ZkIDwgMCkgewogICAgcHJpbnRmKCJFcnJvciBpbiBmaWxlIG9wZW5pbmc6ICVz
XG4iLCBzdHJlcnJvcihlcnJubykpOwogICAgcmV0dXJuIDE7CiAgfQoKICAvLyB3ZSBnZXQgdGhl
IHNhbWUgYmVoYXZpb3IgaWYgd2UgZmFsbG9jYXRlIHRoZSBtYXBwZWQgZmlsZSwgaW5zdGVhZCBv
ZiBmaWxsaW5nIGl0IHdpdGggemVyb3MuCi8vICBpZiAoZmFsbG9jYXRlKG1hcHBlZF9mZCwgMCwg
MCwgbW1hcF9zaXplKSA8IDApIHsKLy8gICAgcHJpbnRmKCJFcnJvciBpbiBmaWxlIGFsbG9jYXRp
b246ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwogLy8gICByZXR1cm4gMTsKICAvL30KCiAgY2hh
ciogcHRyID0gKGNoYXIqKW1tYXAobnVsbHB0ciwgbW1hcF9zaXplLCBQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFLCBNQVBfU0hBUkVELCBtYXBwZWRfZmQsIDApOwoKICAvLyBvcGVuIGFub3RoZXIgZmls
ZSwgYW5kIHdyaXRlIGludG8gaXQgdW50aWwgdGhlIGRpc2sgaXMgZnVsbAogIGNvbnN0IHN0ZDo6
c3RyaW5nIGRhdGFfZmlsZV9wYXRoID0gc3RkOjpzdHJpbmcoZGlyZWN0b3J5KSArICIvZmlsZS5k
YXRhIjsKICAvLyBjcmVhdGUgYSBsYXJnZSBmaWxlIGZpbGxlZCB3aXRoIDAKICB7CiAgICBpbnQg
ZmQgPSBmZF9vcGVuX2ZpbGVfZm9yX2NyZWF0ZShkYXRhX2ZpbGVfcGF0aC5jX3N0cigpKTsKICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgKG1tYXBfc2l6ZSAvIDEwMjQpOyBpKyspIHsKICAgICAgaWYg
KCFhcHBlbmQoZmQsIDEwMjQpKSB7CiAgICAgICAgYnJlYWs7CiAgICAgIH0KICAgIH0KICAgIGNs
b3NlKGZkKTsKICB9CgogIC8vIG5vdywgdHJ5IHRvIHdyaXRlIGludG8gdGhlIG1hcHBlZCBmaWxl
LiBXaXRoIGJ0cmZzLCBpdCBjcmFzaGVzLiBXaXRoIGV4dDQsIGl0IGRvZXMgbm90CiAgcHRyWzBd
ID0gMDsKCiAgY2xvc2UobWFwcGVkX2ZkKTsKfQo=
--000000000000b96b850606322ad7--
