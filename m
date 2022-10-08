Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213C5F83C0
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 08:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJHGAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 02:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJHF6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 01:58:12 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80D80EA9
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 22:57:11 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d187so6872651vsd.6
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBy0p7OT862kT7rLzEGDAL4voAfOz1UoPrvVSb+RLVQ=;
        b=cajwn1DQOWrs15/uIcYdvKe65q4Gs73jWMlQnxBtcLTh5Ykbsy5u/tK7D+BIzuUISe
         f9T1ZfbzqlfjVFGvUg13L+eKU8BEhg/IZ6Z7XXD7tyjx2T8OpAsoazb84dLVrIuKj4bO
         b4u79dFVa+Mz7mH09zoZ6IKrIsMSN339yF0t2SiR94SEyb1IwTXz8X2+oNUJiggbxqMM
         QzwOagAGBtsUaXgr5FHcl4I82cMfbSbde2cE8nHQw8PC8pmPD97TFZLH1eOy118jIqb5
         m8Pixkm7jA1t2F99GvIBnttDDbHa7eYYHajHKVYmC1AKQR2MGtt6rGwfuat8BtXc5wUC
         TYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:reply-to:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBy0p7OT862kT7rLzEGDAL4voAfOz1UoPrvVSb+RLVQ=;
        b=pJJwvl8V5Od5QfAbDjaT5uyIMpvakePgrfLmey9P0Sfm8K6CvIiCRrzS7H/lG30CLc
         oTnUBF/KhFJXCxldLkXAL8vHp+t+Mkvpm/suoYtMmWcEEXcEzYKpLzl+VhG2dnUIQ6Bb
         vXVS0okOY6Y7N1LfFHLanjrBAP0M5f7zaxBVJnaxZueyku/f2AZq4ocQHQGICKuUpRaO
         Njlju7KLbMjRI+gI5mzydMPqaVAA6LVo+j3XFvnOUiAFHmlucsAu1dRJR1FUPmM6sa+f
         y54HUY05y4qEYa25Lnbq/9ZaNzNZFntt7Kzk7o/YWqdHTnYxBnqkuw3cLPuj0iYGBYVq
         uVCw==
X-Gm-Message-State: ACrzQf1JO4Fk6NfZ6zKlxoBtG4xv5dM47QOak6xmTF7YI92BMYq9DWVJ
        oF1l/4EuYcuU3sal/VmA1OVtqYj6VA2HJw==
X-Google-Smtp-Source: AMsMyM6g6zGvWIhVgTX30nOjr383XVWJ+FUkrLCKZVf0gP0g7+AomQ5B0vdXUbWVtmjKiPTJJqmegw==
X-Received: by 2002:a05:6102:3a14:b0:39c:85e5:bcd5 with SMTP id b20-20020a0561023a1400b0039c85e5bcd5mr5343260vsu.80.1665208629783;
        Fri, 07 Oct 2022 22:57:09 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.249])
        by smtp.gmail.com with ESMTPSA id j12-20020a67e3ac000000b003a7633f1edfsm105409vsm.15.2022.10.07.22.57.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 22:57:08 -0700 (PDT)
Date:   Sat, 8 Oct 2022 00:57:04 -0500
From:   Glenn Washburn <development@efficientek.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs send/receive not always sharing extents
Message-ID: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
Reply-To: development@efficientek.com
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/gSC0QyfyDFkSXMaOc3yaHEW"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--MP_/gSC0QyfyDFkSXMaOc3yaHEW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've got two reflinked files in a subvol that I'm sending/receiving to
a different btrfs filesystem and they are not sharing extents on the
receiving side. Other reflinked files in the same subvol are being
reflinked on the receive side. The send side has a fairly old creation
date if that matters. Attached is the receive log and a diff of
filefrag's output for the files on the source volume to show that the
two files (IMG_20200402_143055.dng and IMG_20200402_143055.dng.ref) are
refinked on the source volume. This is a somewhat minimal example of
what's happening on a big send that I'm doing that is failing because
the receive side it too small to hold data when the reflinks are
broken. Is this a bug? or what can I do to get send to see these files
are reflinked?

Glenn

--MP_/gSC0QyfyDFkSXMaOc3yaHEW
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=filefrag.log.diff

--- /dev/fd/63	2022-10-08 00:31:46.783138591 -0500
+++ /dev/fd/62	2022-10-08 00:31:46.787138126 -0500
@@ -1,5 +1,5 @@
 Filesystem type is: 9123683e
-File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng is 24674116 (6024 blocks of 4096 bytes)
+File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref is 24674116 (6024 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..    6023: 1131665768..1131671791:   6024:             last,shared,eof
-/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng: 1 extent found
+/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref: 1 extent found

--MP_/gSC0QyfyDFkSXMaOc3yaHEW
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=btrfs.receive.log.xz

/Td6WFoAAATm1rRGAgAhARwAAAAQz1jM4TbkDtJdACCdAAcz6AycDWCxC04UaNQErWCZjIUYgQ4E
T7fqbIGfjtHlvEwTBHbUTNMfS+DGpbqscserTGVaniwpK79ivARma+cgjqIh7NEPQzR0LfFC15tp
Zw4vMHFsE3Vnro+hTK8FAxNpJR+Aj+kgBBxnEARwvZwk97gyiDLs4AQaGo8shpSVEYJwis5QxQw7
ojPRI5epqGGzEvkB88DXSjvO1U1CQRoSWnZY0RFsvKIt49uZDd/Nx85pAT7Rqr+IO6NkMnJCo1JJ
h/ryxVgAI5jRcnM4O1EooRiphJaEEoJHMIFaIdegEJOy4ThuwP0Ebq8j0qxlzukzOl1ZRIQS+gVI
dckTnKGQ/cvuhGu6/xniBZ9MM1zr0k/Q4Bvz+HpCeCj9nMDE95CPAtUiCuqlYKUQQYmVS872htN3
TpBYn+lubsH7yOKwgP8MSV2qM9R9MANWA/7O/Rz/HKhVwG9fRNnnemoyEFbEGuAJeNBOEYJt5QWD
gdnTXtzVP0KA2vKTOzFXZGytAbxFWnCkpFEgr5W+p7OM1T17/9bZDabMpEBouX4fVW+yW25m3f29
BHZF9Uvn+6C8fffJnGuK7mO7/A5tSC7B+C3VIU2ibof+jksP4IVCLw9krG0Pdmjb9hgbYAzJlr5T
IQflev0BObQPw450/Kzw7eAH6hQR5CHvu4fjWx9jiYqlUHKqXe0KVB/ZJQs50yKgr5hVN4QUkQzd
yfOHWY+6w6y+lfCXBQWcYDFYEBHee7a49mEgvXfwLK3xKYss7Py1uDVpQcMft+dUJMtK5VLX8G5H
RNSD+HWJnMneMvs9qUaRI/8dGlfxAI/6yRmiHSiqPzZUwHxUGraQhwtU7OE5ZP+YRuRbapGOaSyP
y9ZN7Me3zft3L8pJFNSTX+jS8396uoWNkFw83l7mPpgUPTEHXUYPO6dJYCdzybnBFTvKCmZAosnY
fL6oBHQe/tEpjb4sF/cNNFZpDRZeKxStaaMgtEvsMuColnZvoBdcF/9trKMFUK+8VIriF+uVHlBo
6Vr81K5fCE20zQfDkSS6Hcyj/HwoP3z5RR7/XCK+PMzpeeo6EE73bZFDVBs1SVA01lIQjPMTiQhG
BQfHBRDsRxNJvvmB/g7xWr1niTvcsMH9p/2gPBoxJZ2CDcqEfnlFX/qB9bpRxymLIOWYCSswPyXt
2PiVoKDQddhWBQKb4k4M6DG+VIyLUzhGZPEPrjZxs5oRfKutCyTWgiToZXov0Z5/jbY/dgrIh7r2
V8477Dv2MbbwXkAuiwCbCpkeZsnJLpY3yt10ut7MwWkamZyn4zwO08cPid/FjS4MXjAUsVeYU6aU
IaDgmrNPCARhT2XyeHtOE0sq30zN97yH0fZiDW4KKl4Qb95kgb0kZQokPNal1UyvhhpCUBGPisly
BiR6gEQqsQoS5JRdHoVGqGvrlZtDTrvwrGUeJEQB0JgWdf8TB9hZVBsKZl1ZRGtuXATpL7SRmAK9
45s/w+neYZMaYTiDpyt1oqg+kzI7DV5Te28gbpGJqI3im29xn4J6yP3MiR6g4btlLFOul6ys/TeV
/5+9Lq+8Hj/A8yzKEh1Jy/U8STj0SiTsUw6X6yi6mJ/WqcPOheZ9i18ZTOMgvKUfP8AUV2v7Tww9
Ip9/I88hIT/lsxngcb9NFTjN8IRYRQzvBcX7WAzzILAe85iWakp/iqeRKH5oY4/uE9Aj+Ax+UtIG
yIpAL0DuGFEKV0QzWkRfa7BkbGIzbqFNIUbnk5n5ewn/9xrR/L/LyuBrg5HzO7yIZ5fu1dBY2/fI
VfLkEraDuZJ5KwdzfIk5t0BqXWx8mR9NgM2xAKNMbQt6Q/Bvk/Dmr/AF2vaOGziYIrCys7kkVXKY
zyFmUfYPJlL3Wwy8ju5VqdREr8PTf+qD9Pa8YvghnmorywmvJOceKJG1kyClD9VERSPwHqy0hf7+
bSvo4sRWIKnZTwM6PHc68Y+M8mzfE5CqpwD2Au9l1MNLNNv6HYp/m4ui2QHZq2IZxGYEQKSbgn7N
n2B+wxUHQkhY0VssA0hn+Aq+y7ebC1lk8FkwWvo39kmEAVFUfH+40x4cjikgmPGAWVgJE812n5Oe
zdu/01ExkNhbKk0aghO6FKLEvo5tZl3u7vALzEKX1taAEEZSynrB20l+y6/YSfqAMNH7J43eE5J9
6sHvoLn4MVk+nhoM+onskEfDXbBg93/wz/cVz6SdImbRroEWJV0M6/ojzQFFASxHORowhx6PPOyp
arsvpHpHskUyHX1VU9zAUvNYXNk03mMYAHLpZQkBL08wr2JOol45cOPVRWY7QHzFBILYEZCVtV0F
11Vo13EcduglkMVYCqv1ljk/7YiQLTNxJmO2fB0Rn3sFm5w7O/1JqFKWfVM+hXXOPJDytnFJpD8h
SSLlNQV095Y2hEH6cISQjKmcKVFM6CySBOlEpuMr/h0z2gdazJG3hLJJLxwTIOE0HhxLOpUOcU47
YF87JVFj8y3UeCQ2dnyYR6VufKlTsEXlAzQLznrv27EURqDaGDCkjYwFMZcCEFOD843boQ2h0oOV
2GUophlVx2LUVRcUBQvhGXv2STaCEGN3hiVbCc8WbYPQciDjYvzGXm/DZ18DoGZjFRGXHD/8cG3i
q0YsdzptVqPoAwS29GOTi4YPDZ7cso8GOvEHLPwbJ3ZtfyAaExQ1la0Afi8W/5OQOiKiv4eYoOYp
1Ulu9fqSSPHq4GjFOtmnxOdhJV2ja2mYigCERP3CB9e7HhGqjSuDPDGWUw6dbgm/gzzgeCapNXhF
lN8KQHIuJbVbVlOjycFM1inBAPQa488hf4tdofuyXgyUwvzD2NbG/+exmImU9vfw5Sc+sTH7SP7q
+lN2sZvmvrm7HGLzSzyUmA/48XlXtxkdcDic6CpGfHgVJ7/cz4yu4lOayZKmeGQQxHq0mF3KbdL+
snGD7aA/IC8sXQKlc5cJcESqo4OXVPDruRh4pyOjIPK9vmRP8eVckAXBzvRT71Si4XV7f/3MVgdo
honY35LMHEOKTPUpKB9PzOuFoxUwRt4kLXCOlmSqAQQgdfAn6FQztxxuzb32w8xl6oM1/XmBWifS
mBQ8RMq5/ntwJb4mWkR+omacB5DorNvFO1OnY1l+0Ko96uDYxh960yvObuGWAubJN2IxBo8MsfJv
wP5VRtFrbsAkuw5Dp3BnN6cIHIrf8MymHg8Jf60It6xDMOzw4NxRNlFcD04m2Bhsm/a4MC8ufLpf
MQNDO4NX02nxFXWUrlmC5m6uvN8L+t2/Du/3GT/k9E0o1KoZPWMGRrdSoHP9jgEtW74GL7PCuZzg
e+9bjITslTrh+DliO3Kucb5L9egspPiwQPzI3OWoYdi1vA1kM4xuLZraMdR6v2U3PpuT91pWjdi7
oJabW6Qp5dsdpUXEZIEFp00Lomxs6OVkvfhPMi/fKW8Tq5Dp46Bs87ggxb9Js5O3jZQ03HlRO+/H
UsEwBO0+plih3n+sxWugorSwfShVw3AeFO87W91VplQCWXbw6gQE+X9EhuKPWf/AZt/8SRRCsBve
0i05JQGCyycZ31uWqpIoXzJhKEjtxT3+oqrK4O/Q62G2oA4j1QQFBrNivyw8ZeEXkS3/yH0abkXI
zZu/WzGdx7j73N+QVFDApObk4P9QJJ4U0/KXck5IwQT5zfmHgkyKy52oux3FEEuD9x5hKFbGQnjC
XhrPOvQ/SMayfnlinxR42ZKEBvWhsVoLTCqvLdYDPJnsB+KLu86QmgcVBkUa+YSZVJ+cTpr1DQEj
OEh8FlQLuO3rfd242FH1stlWFhq+Hcf+0fNoSj26Fz/NAkibZCNF728/VpCCIT6H7uu3+pAcHafC
sNHu4GK2RXvypFTbKAtKFIaIbM9cOBLhOzBMiaOrPxbKNFGdSWQq+TA75Q0z5x0BqfaF6vVcQkXt
iNbYDKoaEoKeGJpgkpEo+Fsxg0io6woz0zT8fdS/y8jJR3JvUp84vX9LDGG+ywZ8xsogmBW3RN+L
kXcIW2lhfOYd2PJ08oVWHsZPV0pG5P8oYI9U3N/ZupnP0sjgIei5VdM4vO6rgXmKkMIfVOA8hFwB
QMjpLo7D8QMRZ/LIq+3lev8flQdg/bfpXucHSim3KEz5oGZcus3n7MDnkQ4KURbTCmbpqAEXi+OM
rTurEhAXbCa1A39pg7Ojyiu3KwMcd6ZO9Vy6vE8Ro6wx2JiaWvLMonrHIvn6M5KOV98SnuTPNbGA
MOjcIL2gRRB49W93Gu315unzP++ndbDBmdyWke9sfe/hHNiE1LvS221if8K6T6nHgprrW1QFlgaM
u9uUpPyKhCKxCNh8Va9iVaqOS/Y9ufMKn9XJ0vlJCq02qxGXPhA4KJnS9scGcitUtt1GpU/MhjoH
HbRIN8JFhzksEpqUZH3C/Rea22t7+HeERg/48NVEcrWYdR0KL8FChs4VXotPPH8ihGoc+U9nZUJ9
XNTvxtKF4T7fCX934yLuIcLSw27ZZV1bclwxI+9mNXHSeePqnLs1HLt4X+ERhDOjjB0irQjD0SZN
dutoLaC0pjxaow3LKLlGu9LCRQ0ny6oqUHaDMNxaQqNCWlvYQcfQNsaeT9fyfA4sxDTYlfjC/wxf
19i2QrIHe2HXMlTRzFfkC7MjzV4j+JoC73tCv5Vxci/Gi0QX7TtS1BnP0vl8US0DxMBZMS1mieSt
PVRENXOd+AgX75y2LjwNUbc98jDXS50x+Up88R0u6a7oQge+oZhaHMFjWCnHYUXeHgy1IBHfv3QB
2PCFo/D+sdtm9GV8EpiRb31N2oMsMGL7+ZsiRtgR4mgpG7wP3SIWB7HyDNASF61M9Ho9O3/gQrFs
NcKu/dxb3wC41T6b8TDTcBzm5GUGr9PViim0ybttIAD7zkYAH/2CKq+8CyBy4FUpJHhAECE+IxYw
FN/oViYO70hVV0Yfq8VESh5+1GQRAxaDFK3uie7hP7DIxyGztBfro6W86YEw4eFHWiw22/pyhc2P
/L+Ls6VXsExytFsZhOU55qNNUTHz1g5TnUM5u//C1D2QSrDt8hwmXrk5I+eBSgBgiGO0cLr8WMjF
+gEIIRBPAAAAk9DU98nttyUAAe4d5e0EAOHKnFOxxGf7AgAAAAAEWVo=

--MP_/gSC0QyfyDFkSXMaOc3yaHEW--
