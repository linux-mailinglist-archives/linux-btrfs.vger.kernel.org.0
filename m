Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED8677A76
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 13:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAWMDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 07:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAWMDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 07:03:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DE2386D
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 04:03:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w14so14279159edi.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAlOI+grbJpXQf+eRDKYM1yvgo4TkO/HbQPvUZ2Kupc=;
        b=bSRAJNhXVLomAr1dAUf8JKeN63uIl5Qp/sKh6zqMRLr93no5M4Jn7cnQDBqdddA+Pr
         s225ilD7q+U9QAQknct18TNxkcuA6HU1UDlQjfpyZztGuP2rPMcGHeMnC8KHAW9rOr9E
         aiJIjNxaIBHvQpa+DY4rFVNGRSdT49GtKq2MPKjY4XvfL5t0Nehr0u8pEEnN9bz2GjJy
         X+jGqYMV+UvXy0g8nPPpMCSQPRdWuTK3GtVYVUASr+Z/we3oU23la20RT26CYfHUoeUi
         QA2LjXfBGoyznbW8a6uCDWndKmGMDJOV+daQfBf2ZcXX2RRd3QJ4AE7MWKGdTdMCztaZ
         zLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAlOI+grbJpXQf+eRDKYM1yvgo4TkO/HbQPvUZ2Kupc=;
        b=udAOFHp5PNQmrH8c7z7Q+573SC1kj5j5pSDQyo5de1VIbITkIzJSnLIhsCGuApJjOv
         cJV0CmYRAppCeeYhE1ELrZLKHkCMh9RX17RQv0uviqKRzLUjHKVxIu2JDpyaMe3YhDuK
         7YVvPad6V5lPpnFPMJd0rYgQ/FDFA8s6kUGNlqEJIFWfO2/5MuAwN8TQDxTHYfQsV/9n
         u/z0/xeTC15nxoWCQMeYN3Yv1Yb3aRBkpR2yHW/ZWBWHEyZOm0vfx72MT6l3mhwMrmXy
         uCC+Cj3zlVDUkxY6Dba4LJASipxQKP/6huoeP1Y9saUGvsHvHUSDiBYZLQ6J5Es2H1ae
         q7rQ==
X-Gm-Message-State: AFqh2kr4/T01jqeu2DDUVekXQpXMk8bs+8OAq1z+DaRMABzV5Ft9tdqS
        1mdOu/kW9TRahtl08QuJiMo=
X-Google-Smtp-Source: AMrXdXs1lhelUYYsmXeQ4tLoXjkHoomjI7ZBiAurzazJARLYlugfI3qEtyc5OKXCROcWGMwSKbCKUQ==
X-Received: by 2002:aa7:cd86:0:b0:499:27e8:94a3 with SMTP id x6-20020aa7cd86000000b0049927e894a3mr26467348edv.13.1674475406877;
        Mon, 23 Jan 2023 04:03:26 -0800 (PST)
Received: from localhost (tor-exit-at-the.quesadilla.party. [103.251.167.21])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7c7d5000000b0046ac017b007sm21221537eds.18.2023.01.23.04.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:03:26 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:03:10 +0200
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: btrfs corruption, extent buffer leak
Message-ID: <Y853dpWJQjUoBo4Q@mail.gmail.com>
References: <Y8voyTXdnPDz8xwY@mail.gmail.com>
 <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 23, 2023 at 10:39:08AM +0000, Filipe Manana wrote:
> On Sat, Jan 21, 2023 at 1:59 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >
> > Hello,
> >
> > I would like to report an apparent bug in btrfs that happened to me
> > today and ask for help. The report is unlikely to be very helpful,
> > though, because I can't provide an image of the broken filesystem, and I
> > will probably not be able to store it for experiments, as it's 2 TB big.
> > But this is certainly something to pay attention to, as btrfs is
> > concidered stable.
> >
> > My setup is btrfs in LUKS on an SSD, kernel 6.1.3-arch1-1. Out of a
> > sudden, I wasn't able to write a file (-EROFS). I looked in the dmesg
> > and saw the following:
> >
> > [996188.059638] BTRFS critical (device dm-0): corrupt leaf: root=18446744073709551610 block=931164291072 slot=143, bad key order, prev (12490699 96 4368) current (12490699 96 4337)
> > [996188.059648] BTRFS info (device dm-0): leaf 931164291072 gen 200102 total ptrs 213 free space 4379 owner 18446744073709551610
> > [996188.059650]         item 0 key (21184 1 0) itemoff 16123 itemsize 160
> > [996188.059653]                 inode generation 1575 size 1605632 mode 100644
> > [996188.059654]         item 1 key (21184 108 0) itemoff 16070 itemsize 53
> > [996188.059656]                 extent data disk bytenr 1326812942336 nr 4096
> > [996188.059657]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059658]         item 2 key (1841324 1 0) itemoff 15910 itemsize 160
> > [996188.059659]                 inode generation 31479 size 655360 mode 100644
> > [996188.059660]         item 3 key (1841324 108 0) itemoff 15857 itemsize 53
> > [996188.059661]                 extent data disk bytenr 1319827484672 nr 4096
> > [996188.059662]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059663]         item 4 key (6929778 1 0) itemoff 15697 itemsize 160
> > [996188.059664]                 inode generation 165217 size 88 mode 40755
> > [996188.059665]         item 5 key (6929778 12 6929776) itemoff 15682 itemsize 15
> > [996188.059667]         item 6 key (6929778 72 3) itemoff 15674 itemsize 8
> > [996188.059668]         item 7 key (6929778 72 6) itemoff 15666 itemsize 8
> > [996188.059669]         item 8 key (6929778 72 8) itemoff 15658 itemsize 8
> > [996188.059670]         item 9 key (6929778 96 88) itemoff 15611 itemsize 47
> > [996188.059671]         item 10 key (12490699 1 0) itemoff 15451 itemsize 160
> > [996188.059672]                 inode generation 183534 size 4808 mode 40755
> > [996188.059673]         item 11 key (12490699 12 12487122) itemoff 15433 itemsize 18
> > [996188.059675]         item 12 key (12490699 72 2) itemoff 15425 itemsize 8
> > [996188.059676]         item 13 key (12490699 72 4) itemoff 15417 itemsize 8
> > [996188.059677]         item 14 key (12490699 72 7) itemoff 15409 itemsize 8
> > [996188.059678]         item 15 key (12490699 72 12) itemoff 15401 itemsize 8
> > [996188.059679]         item 16 key (12490699 72 20) itemoff 15393 itemsize 8
> > [996188.059680]         item 17 key (12490699 72 24) itemoff 15385 itemsize 8
> > [996188.059681]         item 18 key (12490699 72 28) itemoff 15377 itemsize 8
> > [996188.059682]         item 19 key (12490699 72 32) itemoff 15369 itemsize 8
> > [996188.059683]         item 20 key (12490699 72 34) itemoff 15361 itemsize 8
> > [996188.059684]         item 21 key (12490699 72 37) itemoff 15353 itemsize 8
> > [996188.059685]         item 22 key (12490699 72 46) itemoff 15345 itemsize 8
> > [996188.059686]         item 23 key (12490699 72 48) itemoff 15337 itemsize 8
> > [996188.059687]         item 24 key (12490699 72 50) itemoff 15329 itemsize 8
> > [996188.059688]         item 25 key (12490699 72 52) itemoff 15321 itemsize 8
> > [996188.059689]         item 26 key (12490699 72 59) itemoff 15313 itemsize 8
> > [996188.059690]         item 27 key (12490699 72 62) itemoff 15305 itemsize 8
> > [996188.059691]         item 28 key (12490699 72 77) itemoff 15297 itemsize 8
> > [996188.059692]         item 29 key (12490699 72 80) itemoff 15289 itemsize 8
> > [996188.059693]         item 30 key (12490699 72 83) itemoff 15281 itemsize 8
> > [996188.059694]         item 31 key (12490699 72 87) itemoff 15273 itemsize 8
> > [996188.059695]         item 32 key (12490699 72 91) itemoff 15265 itemsize 8
> > [996188.059696]         item 33 key (12490699 72 93) itemoff 15257 itemsize 8
> > [996188.059697]         item 34 key (12490699 72 97) itemoff 15249 itemsize 8
> > [996188.059699]         item 35 key (12490699 72 105) itemoff 15241 itemsize 8
> > [996188.059700]         item 36 key (12490699 72 115) itemoff 15233 itemsize 8
> > [996188.059701]         item 37 key (12490699 72 133) itemoff 15225 itemsize 8
> > [996188.059702]         item 38 key (12490699 72 230) itemoff 15217 itemsize 8
> > [996188.059703]         item 39 key (12490699 72 291) itemoff 15209 itemsize 8
> > [996188.059704]         item 40 key (12490699 72 354) itemoff 15201 itemsize 8
> > [996188.059705]         item 41 key (12490699 72 432) itemoff 15193 itemsize 8
> > [996188.059706]         item 42 key (12490699 72 510) itemoff 15185 itemsize 8
> > [996188.059707]         item 43 key (12490699 72 561) itemoff 15177 itemsize 8
> > [996188.059708]         item 44 key (12490699 72 620) itemoff 15169 itemsize 8
> > [996188.059709]         item 45 key (12490699 72 671) itemoff 15161 itemsize 8
> > [996188.059710]         item 46 key (12490699 72 706) itemoff 15153 itemsize 8
> > [996188.059711]         item 47 key (12490699 72 794) itemoff 15145 itemsize 8
> > [996188.059712]         item 48 key (12490699 72 842) itemoff 15137 itemsize 8
> > [996188.059713]         item 49 key (12490699 72 913) itemoff 15129 itemsize 8
> > [996188.059714]         item 50 key (12490699 72 986) itemoff 15121 itemsize 8
> > [996188.059715]         item 51 key (12490699 72 1043) itemoff 15113 itemsize 8
> > [996188.059717]         item 52 key (12490699 72 1093) itemoff 15105 itemsize 8
> > [996188.059718]         item 53 key (12490699 72 1156) itemoff 15097 itemsize 8
> > [996188.059719]         item 54 key (12490699 72 1221) itemoff 15089 itemsize 8
> > [996188.059720]         item 55 key (12490699 72 1313) itemoff 15081 itemsize 8
> > [996188.059721]         item 56 key (12490699 72 1368) itemoff 15073 itemsize 8
> > [996188.059722]         item 57 key (12490699 72 1464) itemoff 15065 itemsize 8
> > [996188.059723]         item 58 key (12490699 72 1531) itemoff 15057 itemsize 8
> > [996188.059724]         item 59 key (12490699 72 1575) itemoff 15049 itemsize 8
> > [996188.059725]         item 60 key (12490699 72 1680) itemoff 15041 itemsize 8
> > [996188.059726]         item 61 key (12490699 72 1732) itemoff 15033 itemsize 8
> > [996188.059727]         item 62 key (12490699 72 1781) itemoff 15025 itemsize 8
> > [996188.059728]         item 63 key (12490699 72 1858) itemoff 15017 itemsize 8
> > [996188.059729]         item 64 key (12490699 72 1938) itemoff 15009 itemsize 8
> > [996188.059730]         item 65 key (12490699 72 1999) itemoff 15001 itemsize 8
> > [996188.059731]         item 66 key (12490699 72 2054) itemoff 14993 itemsize 8
> > [996188.059732]         item 67 key (12490699 72 2126) itemoff 14985 itemsize 8
> > [996188.059733]         item 68 key (12490699 72 2211) itemoff 14977 itemsize 8
> > [996188.059734]         item 69 key (12490699 72 2264) itemoff 14969 itemsize 8
> > [996188.059735]         item 70 key (12490699 72 2329) itemoff 14961 itemsize 8
> > [996188.059736]         item 71 key (12490699 72 2460) itemoff 14953 itemsize 8
> > [996188.059737]         item 72 key (12490699 72 2521) itemoff 14945 itemsize 8
> > [996188.059738]         item 73 key (12490699 72 2590) itemoff 14937 itemsize 8
> > [996188.059739]         item 74 key (12490699 72 2665) itemoff 14929 itemsize 8
> > [996188.059740]         item 75 key (12490699 72 2728) itemoff 14921 itemsize 8
> > [996188.059742]         item 76 key (12490699 72 2797) itemoff 14913 itemsize 8
> > [996188.059743]         item 77 key (12490699 72 2959) itemoff 14905 itemsize 8
> > [996188.059744]         item 78 key (12490699 72 3022) itemoff 14897 itemsize 8
> > [996188.059745]         item 79 key (12490699 72 3075) itemoff 14889 itemsize 8
> > [996188.059746]         item 80 key (12490699 72 3136) itemoff 14881 itemsize 8
> > [996188.059747]         item 81 key (12490699 72 3195) itemoff 14873 itemsize 8
> > [996188.059748]         item 82 key (12490699 72 3270) itemoff 14865 itemsize 8
> > [996188.059749]         item 83 key (12490699 72 3348) itemoff 14857 itemsize 8
> > [996188.059750]         item 84 key (12490699 72 3426) itemoff 14849 itemsize 8
> > [996188.059751]         item 85 key (12490699 72 3491) itemoff 14841 itemsize 8
> > [996188.059752]         item 86 key (12490699 72 3549) itemoff 14833 itemsize 8
> > [996188.059753]         item 87 key (12490699 72 3589) itemoff 14825 itemsize 8
> > [996188.059754]         item 88 key (12490699 72 3620) itemoff 14817 itemsize 8
> > [996188.059755]         item 89 key (12490699 72 3643) itemoff 14809 itemsize 8
> > [996188.059756]         item 90 key (12490699 72 3702) itemoff 14801 itemsize 8
> > [996188.059757]         item 91 key (12490699 72 3750) itemoff 14793 itemsize 8
> > [996188.059758]         item 92 key (12490699 72 3782) itemoff 14785 itemsize 8
> > [996188.059759]         item 93 key (12490699 72 3833) itemoff 14777 itemsize 8
> > [996188.059760]         item 94 key (12490699 72 3887) itemoff 14769 itemsize 8
> > [996188.059761]         item 95 key (12490699 72 4006) itemoff 14761 itemsize 8
> > [996188.059762]         item 96 key (12490699 72 4069) itemoff 14753 itemsize 8
> > [996188.059763]         item 97 key (12490699 72 4120) itemoff 14745 itemsize 8
> > [996188.059764]         item 98 key (12490699 72 4192) itemoff 14737 itemsize 8
> > [996188.059765]         item 99 key (12490699 72 4193) itemoff 14729 itemsize 8
> > [996188.059766]         item 100 key (12490699 72 4226) itemoff 14721 itemsize 8
> > [996188.059768]         item 101 key (12490699 72 4258) itemoff 14713 itemsize 8
> > [996188.059769]         item 102 key (12490699 72 4259) itemoff 14705 itemsize 8
> > [996188.059770]         item 103 key (12490699 72 4264) itemoff 14697 itemsize 8
> > [996188.059771]         item 104 key (12490699 72 4273) itemoff 14689 itemsize 8
> > [996188.059772]         item 105 key (12490699 72 4274) itemoff 14681 itemsize 8
> > [996188.059773]         item 106 key (12490699 72 4294) itemoff 14673 itemsize 8
> > [996188.059774]         item 107 key (12490699 72 4295) itemoff 14665 itemsize 8
> > [996188.059775]         item 108 key (12490699 72 4297) itemoff 14657 itemsize 8
> > [996188.059776]         item 109 key (12490699 72 4298) itemoff 14649 itemsize 8
> > [996188.059777]         item 110 key (12490699 72 4300) itemoff 14641 itemsize 8
> > [996188.059778]         item 111 key (12490699 72 4302) itemoff 14633 itemsize 8
> > [996188.059779]         item 112 key (12490699 72 4303) itemoff 14625 itemsize 8
> > [996188.059780]         item 113 key (12490699 72 4306) itemoff 14617 itemsize 8
> > [996188.059781]         item 114 key (12490699 72 4308) itemoff 14609 itemsize 8
> > [996188.059782]         item 115 key (12490699 72 4309) itemoff 14601 itemsize 8
> > [996188.059784]         item 116 key (12490699 72 4313) itemoff 14593 itemsize 8
> > [996188.059785]         item 117 key (12490699 72 4314) itemoff 14585 itemsize 8
> > [996188.059786]         item 118 key (12490699 72 4319) itemoff 14577 itemsize 8
> > [996188.059787]         item 119 key (12490699 72 4320) itemoff 14569 itemsize 8
> > [996188.059788]         item 120 key (12490699 72 4324) itemoff 14561 itemsize 8
> > [996188.059789]         item 121 key (12490699 72 4325) itemoff 14553 itemsize 8
> > [996188.059790]         item 122 key (12490699 72 4326) itemoff 14545 itemsize 8
> > [996188.059791]         item 123 key (12490699 72 4355) itemoff 14537 itemsize 8
> > [996188.059792]         item 124 key (12490699 72 4359) itemoff 14529 itemsize 8
> > [996188.059793]         item 125 key (12490699 72 4363) itemoff 14521 itemsize 8
> > [996188.059794]         item 126 key (12490699 72 4367) itemoff 14513 itemsize 8
> > [996188.059795]         item 127 key (12490699 72 4372) itemoff 14505 itemsize 8
> > [996188.059796]         item 128 key (12490699 72 4374) itemoff 14497 itemsize 8
> > [996188.059797]         item 129 key (12490699 96 4337) itemoff 14439 itemsize 58
> > [996188.059798]         item 130 key (12490699 96 4344) itemoff 14388 itemsize 51
> > [996188.059799]         item 131 key (12490699 96 4346) itemoff 14345 itemsize 43
> > [996188.059800]         item 132 key (12490699 96 4350) itemoff 14289 itemsize 56
> > [996188.059801]         item 133 key (12490699 96 4351) itemoff 14255 itemsize 34
> > [996188.059803]         item 134 key (12490699 96 4352) itemoff 14206 itemsize 49
> > [996188.059804]         item 135 key (12490699 96 4354) itemoff 14156 itemsize 50
> > [996188.059805]         item 136 key (12490699 96 4357) itemoff 14108 itemsize 48
> > [996188.059806]         item 137 key (12490699 96 4358) itemoff 14055 itemsize 53
> > [996188.059807]         item 138 key (12490699 96 4360) itemoff 14002 itemsize 53
> > [996188.059808]         item 139 key (12490699 96 4361) itemoff 13955 itemsize 47
> > [996188.059809]         item 140 key (12490699 96 4362) itemoff 13906 itemsize 49
> > [996188.059810]         item 141 key (12490699 96 4365) itemoff 13858 itemsize 48
> > [996188.059811]         item 142 key (12490699 96 4368) itemoff 13820 itemsize 38
> > [996188.059812]         item 143 key (12490699 96 4337) itemoff 13762 itemsize 58
> > [996188.059813]         item 144 key (12490699 96 4344) itemoff 13711 itemsize 51
> > [996188.059814]         item 145 key (12490699 96 4346) itemoff 13668 itemsize 43
> > [996188.059815]         item 146 key (12490699 96 4350) itemoff 13612 itemsize 56
> > [996188.059816]         item 147 key (12490699 96 4351) itemoff 13578 itemsize 34
> > [996188.059817]         item 148 key (12490699 96 4352) itemoff 13529 itemsize 49
> > [996188.059818]         item 149 key (12490699 96 4354) itemoff 13479 itemsize 50
> > [996188.059819]         item 150 key (12490699 96 4357) itemoff 13431 itemsize 48
> > [996188.059820]         item 151 key (12490699 96 4358) itemoff 13378 itemsize 53
> > [996188.059821]         item 152 key (12490699 96 4360) itemoff 13325 itemsize 53
> > [996188.059822]         item 153 key (12490699 96 4361) itemoff 13278 itemsize 47
> > [996188.059823]         item 154 key (12490699 96 4362) itemoff 13229 itemsize 49
> > [996188.059824]         item 155 key (12490699 96 4365) itemoff 13181 itemsize 48
> > [996188.059826]         item 156 key (12490699 96 4368) itemoff 13143 itemsize 38
> > [996188.059827]         item 157 key (12490699 96 4373) itemoff 13092 itemsize 51
> > [996188.059828]         item 158 key (12490699 96 4375) itemoff 13039 itemsize 53
> > [996188.059829]         item 159 key (12490699 96 4376) itemoff 12983 itemsize 56
> > [996188.059830]         item 160 key (12491146 1 0) itemoff 12823 itemsize 160
> > [996188.059831]                 inode generation 183551 size 98304 mode 100644
> > [996188.059832]         item 161 key (12491146 108 0) itemoff 12770 itemsize 53
> > [996188.059833]                 extent data disk bytenr 1395927384064 nr 65536
> > [996188.059834]                 extent data offset 0 nr 65536 ram 65536
> > [996188.059835]         item 162 key (12491150 1 0) itemoff 12610 itemsize 160
> > [996188.059836]                 inode generation 183551 size 5120 mode 100644
> > [996188.059837]         item 163 key (12491150 108 0) itemoff 12557 itemsize 53
> > [996188.059838]                 extent data disk bytenr 1305164775424 nr 8192
> > [996188.059839]                 extent data offset 0 nr 8192 ram 8192
> > [996188.059840]         item 164 key (12491165 1 0) itemoff 12397 itemsize 160
> > [996188.059841]                 inode generation 183551 size 886 mode 40755
> > [996188.059842]         item 165 key (12491165 12 12491163) itemoff 12384 itemsize 13
> > [996188.059843]         item 166 key (12491165 72 3) itemoff 12376 itemsize 8
> > [996188.059844]         item 167 key (12491165 72 8) itemoff 12368 itemsize 8
> > [996188.059845]         item 168 key (12491165 72 13) itemoff 12360 itemsize 8
> > [996188.059846]         item 169 key (12491165 72 15) itemoff 12352 itemsize 8
> > [996188.059847]         item 170 key (12491165 72 19) itemoff 12344 itemsize 8
> > [996188.059848]         item 171 key (12491165 72 22) itemoff 12336 itemsize 8
> > [996188.059849]         item 172 key (12491165 72 26) itemoff 12328 itemsize 8
> > [996188.059850]         item 173 key (12491165 72 29) itemoff 12320 itemsize 8
> > [996188.059851]         item 174 key (12491165 72 33) itemoff 12312 itemsize 8
> > [996188.059852]         item 175 key (12491165 72 37) itemoff 12304 itemsize 8
> > [996188.059853]         item 176 key (12491165 72 41) itemoff 12296 itemsize 8
> > [996188.059854]         item 177 key (12491203 1 0) itemoff 12136 itemsize 160
> > [996188.059855]                 inode generation 183551 size 49152 mode 100644
> > [996188.059856]         item 178 key (12491203 108 20480) itemoff 12083 itemsize 53
> > [996188.059857]                 extent data disk bytenr 4461441024 nr 4096
> > [996188.059858]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059859]         item 179 key (12491215 1 0) itemoff 11923 itemsize 160
> > [996188.059860]                 inode generation 183551 size 5242880 mode 100644
> > [996188.059861]         item 180 key (12491215 108 32768) itemoff 11870 itemsize 53
> > [996188.059862]                 extent data disk bytenr 153478160384 nr 32768
> > [996188.059863]                 extent data offset 0 nr 32768 ram 32768
> > [996188.059864]         item 181 key (12491215 108 196608) itemoff 11817 itemsize 53
> > [996188.059865]                 extent data disk bytenr 1375927263232 nr 131072
> > [996188.059866]                 extent data offset 0 nr 131072 ram 131072
> > [996188.059867]         item 182 key (12491215 108 393216) itemoff 11764 itemsize 53
> > [996188.059868]                 extent data disk bytenr 1396576878592 nr 98304
> > [996188.059869]                 extent data offset 0 nr 98304 ram 98304
> > [996188.059870]         item 183 key (12491215 108 1146880) itemoff 11711 itemsize 53
> > [996188.059871]                 extent data disk bytenr 1317877542912 nr 32768
> > [996188.059871]                 extent data offset 0 nr 32768 ram 32768
> > [996188.059872]         item 184 key (12491215 108 1703936) itemoff 11658 itemsize 53
> > [996188.059873]                 extent data disk bytenr 1375330340864 nr 65536
> > [996188.059874]                 extent data offset 0 nr 65536 ram 65536
> > [996188.059875]         item 185 key (12491215 108 1802240) itemoff 11605 itemsize 53
> > [996188.059876]                 extent data disk bytenr 1008546021376 nr 32768
> > [996188.059876]                 extent data offset 0 nr 32768 ram 32768
> > [996188.059877]         item 186 key (12491217 1 0) itemoff 11445 itemsize 160
> > [996188.059878]                 inode generation 183551 size 5242880 mode 100644
> > [996188.059879]         item 187 key (12491217 108 131072) itemoff 11392 itemsize 53
> > [996188.059880]                 extent data disk bytenr 1318221713408 nr 98304
> > [996188.059881]                 extent data offset 0 nr 98304 ram 98304
> > [996188.059882]         item 188 key (12491217 108 262144) itemoff 11339 itemsize 53
> > [996188.059883]                 extent data disk bytenr 1322141986816 nr 65536
> > [996188.059883]                 extent data offset 0 nr 65536 ram 65536
> > [996188.059884]         item 189 key (12491269 1 0) itemoff 11179 itemsize 160
> > [996188.059885]                 inode generation 183551 size 65536 mode 100644
> > [996188.059886]         item 190 key (12491269 108 0) itemoff 11126 itemsize 53
> > [996188.059887]                 extent data disk bytenr 1317122703360 nr 32768
> > [996188.059888]                 extent data offset 0 nr 32768 ram 32768
> > [996188.059888]         item 191 key (12491304 1 0) itemoff 10966 itemsize 160
> > [996188.059889]                 inode generation 183552 size 96 mode 40755
> > [996188.059890]         item 192 key (12491304 12 12491302) itemoff 10954 itemsize 12
> > [996188.059891]         item 193 key (12491304 72 3) itemoff 10946 itemsize 8
> > [996188.059893]         item 194 key (12491304 72 9) itemoff 10938 itemsize 8
> > [996188.059894]         item 195 key (12491305 1 0) itemoff 10778 itemsize 160
> > [996188.059895]                 inode generation 183552 size 26624 mode 100644
> > [996188.059895]         item 196 key (12491305 108 0) itemoff 10725 itemsize 53
> > [996188.059897]                 extent data disk bytenr 1316572549120 nr 16384
> > [996188.059897]                 extent data offset 0 nr 16384 ram 16384
> > [996188.059898]         item 197 key (12491305 108 24576) itemoff 10672 itemsize 53
> > [996188.059899]                 extent data disk bytenr 1316572164096 nr 4096
> > [996188.059900]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059901]         item 198 key (12491330 1 0) itemoff 10512 itemsize 160
> > [996188.059902]                 inode generation 183552 size 138 mode 40755
> > [996188.059902]         item 199 key (12491330 12 12491302) itemoff 10499 itemsize 13
> > [996188.059904]         item 200 key (12491330 72 3) itemoff 10491 itemsize 8
> > [996188.059905]         item 201 key (12491330 72 7) itemoff 10483 itemsize 8
> > [996188.059906]         item 202 key (12491330 96 83) itemoff 10427 itemsize 56
> > [996188.059907]         item 203 key (12491331 1 0) itemoff 10267 itemsize 160
> > [996188.059908]                 inode generation 183552 size 57344 mode 100644
> > [996188.059909]         item 204 key (12491331 12 12491330) itemoff 10235 itemsize 32
> > [996188.059910]         item 205 key (12491331 108 0) itemoff 10182 itemsize 53
> > [996188.059911]                 extent data disk bytenr 1303199375360 nr 4096
> > [996188.059912]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059912]         item 206 key (12491331 108 4096) itemoff 10129 itemsize 53
> > [996188.059914]                 extent data disk bytenr 1303199367168 nr 8192
> > [996188.059914]                 extent data offset 4096 nr 4096 ram 8192
> > [996188.059915]         item 207 key (12491331 108 8192) itemoff 10076 itemsize 53
> > [996188.059916]                 extent data disk bytenr 3049730048 nr 8192
> > [996188.059917]                 extent data offset 0 nr 8192 ram 8192
> > [996188.059918]         item 208 key (12491331 108 16384) itemoff 10023 itemsize 53
> > [996188.059919]                 extent data disk bytenr 3082838016 nr 45056
> > [996188.059920]                 extent data offset 16384 nr 4096 ram 45056
> > [996188.059921]         item 209 key (12491331 108 20480) itemoff 9970 itemsize 53
> > [996188.059922]                 extent data disk bytenr 12110196736 nr 4096
> > [996188.059923]                 extent data offset 0 nr 4096 ram 4096
> > [996188.059923]         item 210 key (12491331 108 24576) itemoff 9917 itemsize 53
> > [996188.059924]                 extent data disk bytenr 3082838016 nr 45056
> > [996188.059925]                 extent data offset 24576 nr 20480 ram 45056
> > [996188.059926]         item 211 key (12491331 108 45056) itemoff 9864 itemsize 53
> > [996188.059927]                 extent data disk bytenr 1375926812672 nr 16384
> > [996188.059928]                 extent data offset 0 nr 12288 ram 16384
> > [996188.059929]         item 212 key (12491336 1 0) itemoff 9704 itemsize 160
> > [996188.059930]                 inode generation 183552 size 88 mode 40755
> > [996188.059931] BTRFS error (device dm-0): block=931164291072 write time tree block corruption detected
> > [996188.096296] BTRFS: error (device dm-0: state AL) in free_log_tree:3284: errno=-5 IO failure
> > [996188.096303] BTRFS info (device dm-0: state EAL): forced readonly
> > [996188.102707] BTRFS warning (device dm-0: state EAL): Skipping commit of aborted transaction.
> > [996188.102712] BTRFS: error (device dm-0: state EAL) in cleanup_transaction:1958: errno=-5 IO failure
> >
> 
> This is the same as reported here:
> 
> https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/

So it seems to be a known issue for 6.1. Is there any known workaround,
or should I downgrade the kernel? Is there any risk of running an older
kernel (and an older btrfs driver) on a filesystem that was driven by
6.1?

> > Other than that, I couldn't list files in a directory two levels higher
> > than the file that I attempted to create.
> 
> You couldn't list files while the fs was in RO state, or after
> rebooting? Or both?

Only when it was in readonly. After rebooting, I could access that
directory again, and the contents seemed to be intact.

> What happened exactly when attempting to list files? What error did you get?

Sorry, I didn't write down the error code...

ls didn't show any entries and just displayed one line with an error,
which I didn't save.

> >
> > After rebooting from a live USB, I ran btrfs scrub (no errors found) and
> > btrfs check (some errors found):
> >
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/root
> > UUID: ********-****-****-****-************
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups
> > ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
> > ERROR: loading qgroups from disk: -2
> > ERROR: failed to check quota groups
> 
> This is a different issue, it's the first time I see it, nothing
> related to the previous one. I'm adding Qu to CC since he knows
> qgroups much better than I do, and so he may have an idea.

More info on this: after I rebooted and continued using the filesystem,
I started seeing these messages in dmesg:

BTRFS warning (device dm-0): qgroup rescan is already in progress
BTRFS warning (device dm-0): qgroup rescan is already in progress
...
BTRFS warning (device dm-0): qgroup rescan is already in progress
BTRFS info (device dm-0): qgroup scan completed (inconsistency flag cleared)

These messages repeated multiple times, i.e. qgroup rescan was
apparently constantly triggered multiple times, and even after it was
completed, something retriggered it again and again.

Then I removed a few hundreds of gigabytes of files, deleted most
subvolumes (there were several dozens of docker subvolumes), and I
noticed that quotas became disabled on this filesystem. I reenabled
quotas, rescanned qgroups, and the quota issue seems to be fixed: I no
longer see repeated rescans in dmesg, and btrfs check doesn't show any
errors now.

> > found 1211137126400 bytes used, error(s) found
> > total csum bytes: 1170686968
> > total tree bytes: 10738614272
> > total fs tree bytes: 8738439168
> > total extent tree bytes: 557547520
> > btree space waste bytes: 1726206798
> > file data blocks allocated: 1533753126912
> >  referenced 1324118478848
> > extent buffer leak: start 931127214080 len 16384
> > extent buffer leak: start 103570046976 len 16384
> >
> > The quota error and especially the extent buffer leak error don't look
> > good to me. However, the filesystem seem to mount properly, and so far I
> > didn't find any lost files (still looking). I don't know whether the
> > amount of free space is shown correctly.
> >
> > What should be my steps to fix these errors? I didn't try btrfs check
> > --repair yet, because of numerous warnings not to use it.
> >
> > Also, what is the approximate amount of the data lost due to this extent
> > buffer leak? Is 16384 the number of sectors or the number of bytes?
> 
> Why do you think there's data loss?

The error message looked scary, I thought it meant that some extents
with real data were leaked on the filesystem and became unreferenced.
The "BTRFS critical: corrupt leaf" message in dmesg, followed by
switching to readonly (a standard fallback when the filesystem is
seriously screwed up), also gave me confidence some data were lost.

> The extent buffer leak is just a
> btrfs-progs thing, it means the code failed to release allocated
> memory - but once 'btrfs check' exits, the memory is released. This is
> likely happening due to the qgroups error, some error path is not
> freeing the memory.

That's a relief to hear. I actually noticed that the "start" numbers
weren't consistent if I ran btrfs check multiple times. And this error
disappeared after fixing quotas, so it indeed seems to be related.

I appreciate your help, thanks! What's the best thing to do in these
circumstances to minimize further damage? Should I recreate the
filesystem, or is it fine as it is? Should I downgrade the kernel for
now? If the first error repeats, is there any risk for data loss?

> 
> >
> > Thanks,
> > Max
