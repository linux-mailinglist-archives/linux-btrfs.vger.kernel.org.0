Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0C5B5165
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Sep 2022 23:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIKV7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIKV7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 17:59:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B16434
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662933570;
        bh=rYxCCaTrEMbBOc8g2Rrz63GQ020LhiMq7qEqiagTM/k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YaVDqFgIjJCQbZvWnrReMdft4GBTo8AzHMcpyviVQMgE8WdvX5/tyGE0ma+hcl8Ck
         ERrouvqAxt5uUSTZ4mLsCqyICxdr8/o1Xwq8BZZnHj/La1i/0qk5smwKQ2yRG6oUBO
         Xa3kxHcv9XQCRCFIqk0aYPQMppxyi0eYUKkICE9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1oqxf14Bh5-00XuBx; Sun, 11
 Sep 2022 23:59:29 +0200
Message-ID: <bb330a66-5a36-417c-4307-c2f25b0b8f78@gmx.com>
Date:   Mon, 12 Sep 2022 05:59:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in
 kernel/btrfs-devel and btrfs-progs
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220911233812.FFEF.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220911233812.FFEF.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HiLTOJ6eTPKeEQE9oNHrAuutcMWmWdyjVU20PwQ6C9Gp0vVUPhn
 G6qdOM4Kz3/G88ilyKIEPDDez4Pj3bKS6bTtQ8WYY0l1X3MzNgp4dqKYQFfeO2RcWkY9Yj6
 G6+WlUNaJDlMZqVs9oEgtUivMpwFLd0mvOC6x2pVaWNITRx30Qwl3WFzeNVZuAETKg8LatB
 XyAAmG8CO3kep3/CjnA6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HBL2X2pj2kE=:/H04y/MjTa/DeZ2axFzVPV
 u4zD/VkcDOuSuAXhlipfnAnfL4+eQQ+tYOGMXd2/opukL6uKAkB7O82OPwIZ2ajvw2sE6hZB8
 lmxEznHCK5UEREGr+XFaRK5qin0xgD+RTbtE6yHRakOpZxqTx27A80u8NDzBNYEVWatkyvg8v
 cgMoQyeIPeKZCVVZGwirMOi5jdx4R/jOxvRQxQoYV8kWgrhmy+nzfqIzDFpoIqCiAv2/I6Ga6
 pECPLvqyOfT82a+hJoHLU/5KwaOD+UWrtZQKn2xzTcq9r98IF1Xt8Zx3bbGdEyv7TC3qIg1Cz
 260JInxSEjfLsq0M74ZCSVy+DizO35IgC8tzcFOHAQiBreB73BXbiLLmMAc6VVZsR8jqKaa6T
 WtgQOXDTQ4SEIPRhJyobZwEbjvb/QitaZzYKvMiCBZ0L+hirJHAQZ3udmFyuyfoCcgWCgFmWG
 vZKLvLYNubm23MqpyXUujL3ik92fXK/WadsTVW5rHnJakKj3OumAvzk4ZBiH+re1XtcH77t90
 AsAzcxLGh8Gr3KTsEfeNVRrUYWVgAPXwTIJVcpDs4DtwWXxlt8j87n0L7dQlHv6CSdWQ9s3BD
 ZNf+Ribm9mwaUON8gGg2DVc5yYxBhwIAzfcrAsT7KfUg1Dj2taM3ac2bJMAKrNzLXo19nLynG
 RPsNxt53P+GZCRMh2IqZHDHkmfGSm9jV2czVYyj4W8AlyDrnGyecw2Di3FZ9FMzCHkwW/eIep
 ruGOFEEA4jvsZ2gYUlWMXUfFiH1BJLfYML/YWOxYoxJ3CxivMedkjQ4/Xg/9iICTg6sUiIL6N
 Wedi/nn7dzbg/9xGiW8H4VpYhBIQplfJkaoZSTPrXA9XeyZjn2aGAKYq/u352576dRLVAZveQ
 7RRT5OUazAUpvEoohcSVHC9mwgKxNMTOcP3i8Rm0NrHz1DiIY8E91/UuUw+hp3NIykNpwzN+3
 BDvy1iEAKkduVh15dtwM0JKG2Odc6m5H8KULtv4/ndB09Wm+EbE0DEWHE0LwCfGf3dsDiTMMX
 H9NDcU9j7BxUXj/fdZdYf5Fq0govx9ABzi/A94UMBAaN+XtbkYGkDYN6nlkDfVpopTTmsxZaF
 z07W2kQFH2zgdVK6lmWI0fGrXWP9UP0OauJYQlhzYKYj7MqACIdlhCVhSIzyVIkumyHwMG0Oi
 mSWgGn/KApt3Pmj9+MVxGlFvnH
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/11 23:38, Wang Yugui wrote:
> Hi,
>
> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in kernel/btrfs-devel =
and btrfs-progs
>
> kernel/btrfs-devel	misc-next
> include/uapi/linux/btrfs.h:297:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GRO=
UP_TREE (1ULL << 3)
>
> btrfs-progs
> ./kernel-shared/ctree.h:497:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_=
TREE    (1ULL << 5)

Check the thread for reason:

https://lore.kernel.org/linux-btrfs/20220906161511.GQ13489@twin.jikos.cz/
>
> we need fix the version of btrfs-progs.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/11
>
>
