Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16D3E35EF
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Aug 2021 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhHGOsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Aug 2021 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHGOsC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Aug 2021 10:48:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B0C0613CF
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Aug 2021 07:47:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so27111622pjb.2
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Aug 2021 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=+vkH9j8tUoewZg1MK6qyB8b2x8/B2SkpcZ/QvWtdCow=;
        b=Dd2VK2j0kcSZiocWjc5lEAarkncxrg+GW8XduIIntmPGUZw1KB3d3lQbWyOiVzF1/k
         zscbvoXeRC09c1dhTckIOBIU403+Vbf5D0PJ4ZnEGrxRJ4MenfjZ4iqcTHz4HJIrg+/z
         nlgvxtK4kpMXHuXFBnaC/d2ziQ+demc3hNpfxoVRoG7EMrTU7EPfvATZMirwMR1Xq+GY
         8TTEuAuS0XMM6pRQ3K12uuPsfpWPtEKz2N0ZCFJDDiziKITQzmRjGoPFyJx9wXvkQ+w9
         CdR0nGDlOfvIAL1Syf6MaC4Rmq2xxJkDCHjcac2K/a5zax8Xdqo3iBEuvFcU9afTba0D
         PYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=+vkH9j8tUoewZg1MK6qyB8b2x8/B2SkpcZ/QvWtdCow=;
        b=JeIe7q+TvZIm+3+aXKwASl70rbZAuU5BdwUHTLdgScdK4PWGqGejXpdGzW5eKPpVui
         V3IAoVxoQ17clm+nyjDklhuyqv4B0AB12fzN3ruFijfxN3vvN2Snl05ZWBYyNM94EWiG
         33NWdj7H6NnSBk7RDRFdXIiigZemwiOa9G1gJnmG/uCB+TnVEjjI9ieYSOVkDYoEb5eo
         UJdIyGCkIKE7bx1KFfUTmoHku/NOaZcLOnsEeFzRnsrESH9Jz48pA+a05dpZ0diRcI8f
         Zf0cKttNPJM/ssH+IeTnFlwvGYGrjYz6JjogQIiO+bRoY+jNkx5rbC7Jlq9p7jPI8gbe
         njDQ==
X-Gm-Message-State: AOAM533yipi+SkEsZJy3i7SdVFV35PIcf6pJkTHgylYuKbRR206MPboH
        5ClnpIpVctH4r4C6oGKIYSS1skcpxzUpfw==
X-Google-Smtp-Source: ABdhPJwV3EbJ7XkvEEvKzK8FcMOkp3zvdMOtNzgmfP7HSAcZRsXNnF4t1hvu0/dtOOfPlqERo0Klcg==
X-Received: by 2002:a17:902:c205:b029:12c:daac:c8a0 with SMTP id 5-20020a170902c205b029012cdaacc8a0mr13021831pll.13.1628347664330;
        Sat, 07 Aug 2021 07:47:44 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id c15sm11814625pjr.22.2021.08.07.07.47.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 07:47:44 -0700 (PDT)
Date:   Sat, 7 Aug 2021 14:47:36 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Simple question for newbie developer about qgroup
Message-ID: <20210807144736.GA2820@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I read btrfs kernel source code about qgroup. I want to know about how
works adding or deleting qgroups. and I read the function
__del_qgroup_relation() in qgroup.c. 

This function checks whether dst is parent for src and store the result
in variable named found. I think if the checks failed, the function
needs to be failed or print warning message at least. Am I right? Or do
you have other intentions?
