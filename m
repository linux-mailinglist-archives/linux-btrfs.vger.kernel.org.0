Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA853F12DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhHSFp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:45:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:59645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSFpz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629351914;
        bh=0faJSBM5VY14VQfO0ZFZKP7bgyy0Tm/aj4oq30MeFcg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QeQiltX+mpuxA1e11UQQmo7NB19J4ehL6bGTi1pv80fKzhsLcTE2P+CLcayW7fW/X
         Ro5BiscKzIVpQVoHKRI6cppvRq6mtNxC4+PhPdHu7AcbKuNhm6JxfySoEnxF0Cem9z
         DZ6k6o8g3DC6rEyztY9kyWzrd4xyDsmlur2ihe+M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlT2-1mxrUl3E6I-00joXG; Thu, 19
 Aug 2021 07:45:14 +0200
Subject: Re: [PATCH v2 04/12] btrfs-progs: propagate extent item errors in
 lowmem mode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <06d91ded263de8668fdbb72d86eb26ab4dfaec45.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e0df5fff-4b59-b48a-4e78-b8ea1a98c1c0@gmx.com>
Date:   Thu, 19 Aug 2021 13:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <06d91ded263de8668fdbb72d86eb26ab4dfaec45.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PA2W4mxasAPNui+kc9JfBAZkeaexJtH4RouaXx06hHbW6JJrdf2
 1MmToQ1w+c1wipexUJ9sA4z0QGlW78V3ezDRtwJGyBzjbTM371ZUivoOXqYoybSe7KC5Lj3
 SEEx8QyWzmbPolI+ObLUv0o1FVMIfZ43hTldO4pRarzvUzGOzpq5d8SvT/UPngBwrkGDdWb
 RZyZOkic7w3ejapsJIHOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/bTs2HXctk=:b2HWlCNzGQdW5n/wxbY5uY
 HHO2OBxBMdSSl560TUxdPqY9WUfWcKqLbKYHQLvZvpiDHgl8euIEOzE624unDlwEXvRiB6Hhu
 zWdPZCgvW3vbw14cmpf2ygpX5YBKMKt+M9wpu7qdgKH9oCu7XzQNHeZ++CwHHYUIQFKBoOjkT
 se7RVvV3f9LxO/5SsFb/3Q1L/9dLfthwvZ/o8G3NkvebUUv1aJAkofgUKvYz+fQ63HUeBNIg7
 5tsLKbRZ4bt049V80prlbq0jTGQcWZWzlvPbxxIwdH3vylWkTVlS2fzcohmZzKMEtVBTZ5skw
 1joS4CNZ2KbBXTQugtyQ+7p8Gy+dYTP9JxAFRmtqgpb9Sgaft47hGMjRdsGARF1bTdV6FUWt9
 d6gZqOYsXlP0DjB+E1//tXevzT+WyjJgL6PWXo7EpFi2EJhyyU9U7B4IE5KjLBfpyLW8OKdj9
 27peEM8kBZ3qCOfPQmkJOdGCfd9xm2zajEOJVze9cqmKvAtbBPbzvqvXmeqTFUisI2udpusLn
 ZESiuJOnvZz1cK16RDEw/OmHbLRC8R4dsBqn6gnWPZr6sKrlConDCBGm8EiS5J4rN0ln9ITB5
 WHSgwblIvmAgp7evxQYQt1hrfWBs8LFNUPnuN+WFSFrtfPqu2p9+1FEpGdfr3/ZYujt/kIYkL
 mXQtoPae+7XmcfmqYlenYs+zmREOqkN3EqFGs46N+U12cp4Ze0jvpErFdiwB9SIjn7jzWPquJ
 ldboUxZnh24hX28DRnOeTZDphAxAMZn7Djm+/SbLWR+L6sfNpdAXkzWtJz7FxivSCxu1rhsxB
 vn0d3i4vLIHceDJUEpDJRG4rZDqLOD9PqA+aY/7VCKim5D4GrZ/J4dxSmXMlgehzrHQ7X9DzL
 n8oF2e92Lx7fL4I80ABNGJo1Bvjv9Ywl4t/MA01tWvS1e0Lp8Q6Lz70ChJRMj4ZjfwHRrxrf7
 5Hydprq/lSR4MmZe7Cx9qNcNfqrfPYq6k8d82/Pd+lVwUZ+kNBP3urENpsNAABXuvKmUMNn8b
 dW4gf15a4+Zj3NzTVyd/7rd01EgF8gyNLoRe0/4TnF63GANzO0eFZ3bVGsAqnHF+TFWcCUSbS
 Ni7ejTmVv8N81dzBpUwW5o38ExyI63AkcFBdsgpBFaqYhp0en5/HJjUVQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> Test 044 was failing with lowmem because it was not bubbling up the
> error to the user.  This is because we try to allow repair the
> opportunity to clear the error, however if repair isn't set we simply do
> not add the temporary error to the main error return variable.  Fix this
> by adding the tmp_err to err before moving on to the next item.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   check/mode-lowmem.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index d278c927..14815519 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -4390,6 +4390,7 @@ next:
>   		goto next;
>   	}
>
> +	err |=3D tmp_err;
>   	ptr_offset +=3D btrfs_extent_inline_ref_size(type);
>   	goto next;
>
>
