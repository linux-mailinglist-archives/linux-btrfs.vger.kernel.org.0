Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C3343627
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 02:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCVBPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 21:15:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:45133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhCVBOX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 21:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616375661;
        bh=1QSL3RHgLMoxHbDklI9X1FO2n68PZvmZKb97iVJlwTA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eFOO4ASCNGZepTsSL4mkEPET+jDokpD4fQGK3SDqtUFBKfPXRWpfyJH3Z5rN1Juoa
         +CwATFA7tE0qitpA71FJNv+cIdS5VJ581q/1YZsSDB75E5k3YFieYdVxAOBKFdYb+P
         fjWztWCGJDERm3CuPkYSN6sKLgH8ErinRcctYR4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1Obh-1lpfRX2eM7-012qFq; Mon, 22
 Mar 2021 02:14:21 +0100
Subject: Re: Simple question for comment in btrfs-progs qgroup code
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210321113342.GA3319@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9c8d9a67-e4fa-93b9-ba8a-d045156153ff@gmx.com>
Date:   Mon, 22 Mar 2021 09:14:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210321113342.GA3319@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HtXFSxaEvN1APSJlKPS+5MmgBzHZn4UcT6IxIsmFV3K5zet860t
 Qc3V/rhfVgvvk2KnPjJCt50jhOwTazJOGzyGcMyPTwW9baYjIE2zIWpQaTg3Lu8CnpdtMYy
 Mgud6DDPGK1ujX0ekFcJ93w5TRvHdb76gHR9eCH9MH8h+JVWmWhsAmr6ALx2BiYoX2OoPWo
 SDBvYkwNIwe3fW8g2VE+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5FhJZi/wEag=:GvtH2giWkLN6uMi4VxwUCi
 cr02u5KkMMh1ZqlJbcD33xwnkxql9j8RIBcEoeR+k2IGYL62Nos0g0A7402wA9LMU4/PvOX6s
 vgUIjgz9cTzosqbM8V2/fWRblOw7QIkHvDwfjDwyvid+AuASzjov2CZgf6qAYJyyoy5bdQqJg
 S1DxF+oxdQ7Yz6Om1mtmVGolO2D6rWhEnkx6QlWkG21XZphOu1ImfKct31SgzY5ztLChhlRC6
 YO/yJjHERAuNm885Xy9IyNKL62+GJtZIZ7IAO2nzW3Tp3Zf+SOKg7p3rcEYsu9kkCg6dpvjp7
 0Lqz6qcEmz4j5gMonackkcTPRlRbKudagsm73BZyBZs2O39Qc5ukgdjLz4m39Drt4E/NLFujE
 OilDlIA3Yr9fpPKOfM+tRAG4W9O4ZUIY+JBgkN7Ig0y038CH4/Tob5L1ZK6EgUR7MY21OgNmP
 2AJyoqps5o+N1a9ERsLFdLYxpiNSQdVwwN0B1VOsg8Khm0sBr6W+m1ZOhtJOfVdVGRYS3199U
 frTB3Afu0YO3W10D4evlF7ZdCaNrX0jaQPqh9RFa9l+Ubt3elnYt5nQRG68zdP9Cs0NE8ad2i
 Wn1CwA5C5LzpfVvKS8OMVW+iISyCEH2NwTLfLoW+Xe7R5CxG/i+K/M0SAvbRqwOc3Z0FmlIj+
 BkbE340ndECRq05lz/wRoW6BI7kR8g8EdBSRnMuX5EV0fJYj8HVMAt9b9cW0iURs4NE6AGZ/O
 rfRyx70WWClu539sz9UBM5+OlhSiqBfK++DzGjM3QzMe64yawLqIjnddyS1iVl9qFv+NfoCPf
 sR6x1sxI+hvFOhHKRPOtCAGJPUcMIRMrs+6TZzppGrI3OMMiXqorkYxzanjycE6uNHFfXWn/4
 nsNLCpa9Bm3NX32nd/sLpMy5PjXveOluur2xepzSgidDCc+By4ExhcwO3JUaiTMHGhlKVkJvR
 RXa77qDgv0ewY7w/PNkLkKzVoQpPBa3Z8Jz5io0ORQiIGsy65B9ehRbm0G3Aq25sGUranrR3o
 4/oSHT15UHV1aB3K4uF/IGQXBCsif6k405rljwiZAeNQpsnqvP7rLwqZLLPAA+IEvNyCyHcZP
 6aoj9n+CZuT+s/60YcMv3ANcgtt0fkZO0Rsgh7QMcmJksoHemGOryl9V8I20pUlkVNDwbKhwN
 tw2uuT89LfOYpgB0jmZ2aaCmCS0Sutnl5xsuW91VusDyZS0vFRQeBEkbAqYUcdC0iIsuaq2Ve
 PkMtQvXCtaEDj3Wf3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/21 =E4=B8=8B=E5=8D=887:33, Sidong Yang wrote:
> Hello!
>
> I see an comment in qgroup cmds below.
>
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index 2da83ffd..a71089e9 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -84,6 +84,7 @@ static int _cmd_qgroup_assign(const struct cmd_struct
> *cmd, int assign,
> 	/*
> 	* FIXME src should accept subvol path
> 	*/
>
> This comment is little confusing for me. src was parsed with
> parse_qgroupid() and it also accepts subvol path. is it outdated
> comment? or src should accept only lowest level of qgroup?

It's outdated and confusing.

For the assign ioctl, it only accepts 3 u64 parameters,
assign:bool to indicate if it's adding or deleting qgroup relationship.
src/dst to specify the qgroupid (u64).

There is no room for path at all.

The qgroupid resolve is done completely in user space.

Feel free to delete the comment.

>
> Thanks,
> Sidong
>
